import 'dart:ui' show Color;

import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/fill_state.dart';

/// Result of attempting to fill a region.
enum FillResultType {
  /// Fill succeeded.
  success,

  /// The region doesn't exist in the level.
  invalidRegion,

  /// The selected palette slot doesn't match the region's required slot.
  wrongPalette,

  /// The region is already filled.
  alreadyFilled,
}

/// Detailed result of a fill attempt.
class FillResult {
  final FillResultType type;
  final int regionId;
  final List<TriggerDefinition> triggers;

  const FillResult({
    required this.type,
    required this.regionId,
    this.triggers = const [],
  });

  bool get isSuccess => type == FillResultType.success;
}

/// Orchestrates the fill logic for the coloring game.
///
/// Validates taps, updates visual state, and returns triggers to execute.
/// Persistence to Drift is handled by the caller (game screen / provider).
class FillController {
  /// The level definition being played.
  final LevelDefinition level;

  /// The visual fill state.
  final FillState fillState;

  /// Region definitions indexed by ID for O(1) lookup.
  final Map<int, RegionDefinition> _regionMap;

  FillController({
    required this.level,
    required this.fillState,
  }) : _regionMap = {
          for (final r in level.regions) r.id: r,
        };

  /// The total number of regions in the level.
  int get totalRegions => level.regions.length;

  /// The number of filled regions.
  int get filledRegions => fillState.filledCount;

  /// Whether all regions are filled (level complete).
  bool get isComplete => filledRegions >= totalRegions;

  /// Get the region definition for a region ID (null if invalid).
  RegionDefinition? getRegion(int regionId) => _regionMap[regionId];

  /// Collect all unique palette slots used in this level, sorted.
  List<int> get paletteSlots {
    final slots = level.regions.map((r) => r.paletteSlot).toSet().toList();
    slots.sort();
    return slots;
  }

  /// Get the target color for a palette slot (from the first region using it).
  Color? getPaletteColor(int slot) {
    final region = level.regions.where((r) => r.paletteSlot == slot).firstOrNull;
    if (region == null) return null;
    return _hexToColor(region.targetColor);
  }

  /// Process a tap on a region with the currently selected palette slot.
  ///
  /// Returns a [FillResult] describing what happened:
  /// - `success`: region was filled, triggers are returned for execution
  /// - `invalidRegion`: region ID doesn't exist in this level
  /// - `wrongPalette`: selected slot doesn't match the region's required slot
  /// - `alreadyFilled`: region was already colored
  FillResult processRegionTap(int regionId, int selectedPaletteSlot) {
    // 1. Check region exists
    final region = _regionMap[regionId];
    if (region == null) {
      return FillResult(
        type: FillResultType.invalidRegion,
        regionId: regionId,
      );
    }

    // 2. Check not already filled
    if (fillState.isFilled(regionId)) {
      return FillResult(
        type: FillResultType.alreadyFilled,
        regionId: regionId,
      );
    }

    // 3. Check palette slot matches
    if (region.paletteSlot != selectedPaletteSlot) {
      return FillResult(
        type: FillResultType.wrongPalette,
        regionId: regionId,
      );
    }

    // 4. Fill the region
    final color = _hexToColor(region.targetColor);
    fillState.markFilled(regionId, color);

    // 5. Return success with triggers to execute
    return FillResult(
      type: FillResultType.success,
      regionId: regionId,
      triggers: region.onFillTriggers,
    );
  }

  /// Parse a hex color string to a Color with safe fallback.
  static Color _hexToColor(String hex) {
    try {
      hex = hex.replaceFirst('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return const Color(0xFF888888);
    }
  }
}
