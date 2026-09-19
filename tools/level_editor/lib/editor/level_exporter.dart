import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:colorverse/models/models.dart';

import 'region_detector.dart';
import 'region_mask_encoder.dart';

/// Result of a level export operation.
class ExportResult {
  /// Whether the export completed successfully.
  final bool success;

  /// Validation errors (export is blocked if non-empty).
  final List<String> errors;

  /// Non-fatal warnings (export proceeds but these are reported).
  final List<String> warnings;

  /// Where the files were written (null if export failed).
  final String? outputDir;

  const ExportResult({
    required this.success,
    this.errors = const [],
    this.warnings = const [],
    this.outputDir,
  });
}

/// Validates and exports a complete level to disk.
///
/// Produces three files:
/// - `{levelId}_lineart.png` — pass-through of the original line art
/// - `{levelId}_regionmask.png` — re-encoded ID mask
/// - `level.json` — the complete level definition
///
/// Validates before export:
/// 1. All region IDs referenced by triggers exist in the mask
/// 2. All chain target region IDs exist
/// 3. All hidden event condition region IDs exist
/// 4. Optionally validates that referenced asset files exist on disk
class LevelExporter {
  LevelExporter._();

  /// Validate a [LevelDefinition] against the detected regions.
  ///
  /// Returns a list of error strings. Empty = valid.
  static List<String> validate(
    LevelDefinition level,
    List<DetectedRegion> regions,
  ) {
    final errors = <String>[];
    final validIds = regions.map((r) => r.assignedId).toSet();

    // Check that every region in the level definition has a valid ID
    for (final region in level.regions) {
      if (!validIds.contains(region.id)) {
        errors.add(
          'Region ID ${region.id} in level definition does not exist in the mask.',
        );
      }

      // Check trigger references
      for (final trigger in region.onFillTriggers) {
        switch (trigger) {
          case ChainTrigger(:final targetRegionId):
            if (!validIds.contains(targetRegionId)) {
              errors.add(
                'Region ${region.id}: chain trigger references non-existent '
                'target region ID $targetRegionId.',
              );
            }
            // Check that chain doesn't target self
            if (targetRegionId == region.id) {
              errors.add(
                'Region ${region.id}: chain trigger references itself (infinite loop).',
              );
            }
          case AnimationTrigger(:final asset):
            if (asset.isEmpty) {
              errors.add(
                'Region ${region.id}: animation trigger has empty asset path.',
              );
            }
          case SfxTrigger(:final asset):
            if (asset.isEmpty) {
              errors.add(
                'Region ${region.id}: SFX trigger has empty asset path.',
              );
            }
        }
      }
    }

    // Check hidden event references
    for (final event in level.hiddenEvents) {
      final conditionIds = switch (event.condition) {
        AllRegionsFilledCondition(:final regionIds) => regionIds,
        AnyRegionFilledCondition(:final regionIds) => regionIds,
        RegionFilledWithinTimeCondition(:final regionIds) => regionIds,
      };

      for (final id in conditionIds) {
        if (!validIds.contains(id)) {
          errors.add(
            'Hidden event "${event.id}": condition references '
            'non-existent region ID $id.',
          );
        }
      }
    }

    // Check for duplicate region IDs in the level definition
    final definedIds = level.regions.map((r) => r.id).toList();
    final duplicates = definedIds.where(
      (id) => definedIds.where((d) => d == id).length > 1,
    ).toSet();
    for (final dup in duplicates) {
      errors.add('Duplicate region ID $dup in level definition.');
    }

    return errors;
  }

  /// Validate that referenced asset files exist on disk.
  static List<String> validateAssets(
    LevelDefinition level,
    String assetLibraryDir,
  ) {
    final warnings = <String>[];

    for (final region in level.regions) {
      for (final trigger in region.onFillTriggers) {
        String? assetPath;
        switch (trigger) {
          case AnimationTrigger(:final asset):
            assetPath = asset;
          case SfxTrigger(:final asset):
            assetPath = asset;
          case ChainTrigger():
            break;
        }

        if (assetPath != null) {
          final file = File('$assetLibraryDir/$assetPath');
          if (!file.existsSync()) {
            warnings.add(
              'Asset file not found: $assetPath '
              '(referenced by region ${region.id}). '
              'This may be created later.',
            );
          }
        }
      }
    }

    return warnings;
  }

  /// Export a level to disk.
  ///
  /// [level] is the complete level definition to export.
  /// [regions] are the detected regions from the overlay image.
  /// [lineArtBytes] is the original line art PNG bytes.
  /// [outputDir] is the directory to write files to.
  /// [assetLibraryDir] is an optional directory to check for asset existence.
  static Future<ExportResult> export({
    required LevelDefinition level,
    required List<DetectedRegion> regions,
    required Uint8List lineArtBytes,
    required int maskWidth,
    required int maskHeight,
    required String outputDir,
    String? assetLibraryDir,
  }) async {
    // Validate
    final errors = validate(level, regions);
    if (errors.isNotEmpty) {
      return ExportResult(success: false, errors: errors);
    }

    // Check assets (warnings only, don't block)
    final warnings = <String>[];
    if (assetLibraryDir != null) {
      warnings.addAll(validateAssets(level, assetLibraryDir));
    }

    try {
      // Ensure output directory exists
      final dir = Directory(outputDir);
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }

      // Write line art (pass-through)
      final lineArtFile = File('$outputDir/${level.levelId}_lineart.png');
      await lineArtFile.writeAsBytes(lineArtBytes);

      // Encode and write region mask
      final maskBytes = RegionMaskEncoder.encode(
        regions,
        maskWidth,
        maskHeight,
      );
      final maskFile = File('$outputDir/${level.levelId}_regionmask.png');
      await maskFile.writeAsBytes(maskBytes);

      // Write level.json
      final json = level.toJson();
      final jsonString =
          const JsonEncoder.withIndent('  ').convert(json);
      final jsonFile = File('$outputDir/level.json');
      await jsonFile.writeAsString(jsonString);

      return ExportResult(
        success: true,
        warnings: warnings,
        outputDir: outputDir,
      );
    } catch (e) {
      return ExportResult(
        success: false,
        errors: ['Export failed: $e'],
        warnings: warnings,
      );
    }
  }
}
