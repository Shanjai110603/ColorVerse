import 'dart:convert';
import 'dart:ui' show Color;

import 'package:flutter/services.dart' show rootBundle;

import 'package:colorverse/animations/hidden_event_evaluator.dart';
import 'package:colorverse/coloring/fill_controller.dart';
import 'package:colorverse/engine/colorverse_game.dart';
import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/fill_state.dart';
import 'package:colorverse/rendering/region_mask_buffer.dart';

/// Orchestrates level loading — decodes images, parses JSON, builds the game.
///
/// Performance target: < 1 second total on mid-range hardware.
/// Heavy work (mask decoding) runs in a background isolate.
class LevelLoader {
  LevelLoader._();

  /// Load a level from the app's asset bundle.
  ///
  /// Expected asset structure:
  /// ```
  /// assets/sample_levels/{levelId}/
  ///   level.json
  ///   {levelId}_lineart.png
  ///   {levelId}_regionmask.png
  /// ```
  static Future<ColorVerseGame> load(
    String levelId, {
    Set<int>? restoredFills,
    Map<int, int>? restoredColors,
    bool colorblindMode = false,
  }) async {
    final basePath = 'assets/sample_levels/$levelId';

    // 1. Parse level.json
    final jsonString = await rootBundle.loadString('$basePath/level.json');
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final level = LevelDefinition.fromJson(json);

    // Index regions for quick color lookup on restore
    final regionMap = {for (final r in level.regions) r.id: r};

    // 2. Load images in parallel
    final results = await Future.wait([
      rootBundle.load('$basePath/${level.lineArt}'),
      rootBundle.load('$basePath/${level.regionMask}'),
    ]);

    final lineArtBytes = results[0].buffer.asUint8List();
    final maskBytes = results[1].buffer.asUint8List();

    // 3. Decode mask in background isolate (heavy work)
    final maskBuffer = await RegionMaskBuffer.load(maskBytes);

    // 4. Build fill state (restore from save if available)
    final fillState = FillState();
    if (restoredFills != null) {
      for (final regionId in restoredFills) {
        Color? color;
        if (restoredColors != null && restoredColors.containsKey(regionId)) {
          color = Color(restoredColors[regionId]!);
        } else {
          final region = regionMap[regionId];
          if (region != null) {
            color = _hexToColor(region.targetColor);
          }
        }
        if (color != null) {
          fillState.markFilled(regionId, color);
        }
      }
    }

    // 5. Build fill controller
    final fillController = FillController(
      level: level,
      fillState: fillState,
    );

    // 6. Build hidden event evaluator
    final hiddenEventEvaluator = HiddenEventEvaluator(
      events: level.hiddenEvents,
      fillState: fillState,
    );

    // 7. Determine initial palette slot
    final slots = fillController.paletteSlots;
    final initialSlot = slots.isNotEmpty ? slots.first : 1;

    // 8. Create game instance
    final game = ColorVerseGame(
      level: level,
      maskBuffer: maskBuffer,
      fillState: fillState,
      fillController: fillController,
      hiddenEventEvaluator: hiddenEventEvaluator,
      lineArtBytes: lineArtBytes,
      selectedPaletteSlot: initialSlot,
      colorblindMode: colorblindMode,
    );

    // 9. Preload SFX assets listed across all regions
    final sfxAssets = <String>{};
    for (final r in level.regions) {
      for (final trigger in r.onFillTriggers) {
        if (trigger is SfxTrigger && trigger.asset.isNotEmpty) {
          sfxAssets.add(trigger.asset);
        }
      }
    }
    if (sfxAssets.isNotEmpty) {
      await game.audioManager.preloadSfx(sfxAssets.toList());
    }

    return game;
  }

  static Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
