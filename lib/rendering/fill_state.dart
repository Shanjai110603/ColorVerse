import 'dart:ui' show Color;

/// Tracks which regions are currently filled and their visual colors.
///
/// Bridges the persistent Drift save data with the in-game visual state.
/// Updated on each fill event and consulted by the overlay renderer.
class FillState {
  /// Set of region IDs that have been filled.
  final Set<int> _filledRegionIds;

  /// Map of region ID → fill color for rendering.
  final Map<int, Color> _regionColors;

  FillState({
    Set<int>? initialFilledIds,
    Map<int, Color>? regionColors,
  })  : _filledRegionIds = initialFilledIds ?? {},
        _regionColors = regionColors ?? {};

  /// Whether a region has been filled.
  bool isFilled(int regionId) => _filledRegionIds.contains(regionId);

  /// Get the fill color for a region (null if not filled).
  Color? getColor(int regionId) => _regionColors[regionId];

  /// All currently filled region IDs.
  Set<int> get filledRegionIds => Set.unmodifiable(_filledRegionIds);

  /// Total number of filled regions.
  int get filledCount => _filledRegionIds.length;

  /// Mark a region as filled with the given color.
  /// Returns true if the region was newly filled (not already filled).
  bool markFilled(int regionId, Color color) {
    if (_filledRegionIds.contains(regionId)) return false;
    _filledRegionIds.add(regionId);
    _regionColors[regionId] = color;
    return true;
  }

  /// Undo the last fill (remove a specific region).
  /// Returns true if the region was actually filled.
  bool unfill(int regionId) {
    final removed = _filledRegionIds.remove(regionId);
    _regionColors.remove(regionId);
    return removed;
  }

  /// Clear all fills (for level reset).
  void clear() {
    _filledRegionIds.clear();
    _regionColors.clear();
  }
}
