import 'dart:typed_data';

import 'package:colorverse/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../utils/image_utils.dart';
import 'region_detector.dart';

/// Immutable state for the level editor.
class EditorState {
  /// The line art image bytes (original PNG).
  final Uint8List? lineArtBytes;

  /// The decoded line art image (for display).
  final img.Image? lineArtImage;

  /// The overlay image bytes (original artist overlay).
  final Uint8List? overlayBytes;

  /// The decoded overlay image.
  final img.Image? overlayImage;

  /// Detected regions from the overlay image.
  final List<DetectedRegion> detectedRegions;

  /// The currently selected region (by assigned ID), or null.
  final int? selectedRegionId;

  /// The level definition being edited.
  final LevelDefinition? levelDefinition;

  /// Region definitions mapped by ID for quick lookup.
  final Map<int, RegionDefinition> regionDefinitions;

  /// Whether the editor has unsaved changes.
  final bool isDirty;

  /// Status message for the bottom bar.
  final String statusMessage;

  const EditorState({
    this.lineArtBytes,
    this.lineArtImage,
    this.overlayBytes,
    this.overlayImage,
    this.detectedRegions = const [],
    this.selectedRegionId,
    this.levelDefinition,
    this.regionDefinitions = const {},
    this.isDirty = false,
    this.statusMessage = 'Ready — import images to begin.',
  });

  EditorState copyWith({
    Uint8List? lineArtBytes,
    img.Image? lineArtImage,
    Uint8List? overlayBytes,
    img.Image? overlayImage,
    List<DetectedRegion>? detectedRegions,
    int? Function()? selectedRegionId,
    LevelDefinition? levelDefinition,
    Map<int, RegionDefinition>? regionDefinitions,
    bool? isDirty,
    String? statusMessage,
  }) {
    return EditorState(
      lineArtBytes: lineArtBytes ?? this.lineArtBytes,
      lineArtImage: lineArtImage ?? this.lineArtImage,
      overlayBytes: overlayBytes ?? this.overlayBytes,
      overlayImage: overlayImage ?? this.overlayImage,
      detectedRegions: detectedRegions ?? this.detectedRegions,
      selectedRegionId:
          selectedRegionId != null ? selectedRegionId() : this.selectedRegionId,
      levelDefinition: levelDefinition ?? this.levelDefinition,
      regionDefinitions: regionDefinitions ?? this.regionDefinitions,
      isDirty: isDirty ?? this.isDirty,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }
}

/// Manages all editor state. This is the single source of truth for
/// the level editor UI.
class EditorNotifier extends StateNotifier<EditorState> {
  EditorNotifier() : super(const EditorState());

  /// Load line art image from bytes.
  void loadLineArt(Uint8List bytes) {
    final image = ImageUtils.decodePng(bytes);
    state = state.copyWith(
      lineArtBytes: bytes,
      lineArtImage: image,
      isDirty: true,
      statusMessage:
          'Line art loaded (${image.width}×${image.height}).',
    );
  }

  /// Load overlay image and auto-detect regions.
  void loadOverlay(Uint8List bytes) {
    final image = ImageUtils.decodePng(bytes);
    final regions = RegionDetector.detect(image);

    // Create default region definitions for each detected region
    final defs = <int, RegionDefinition>{};
    for (final region in regions) {
      defs[region.assignedId] = RegionDefinition(
        id: region.assignedId,
        targetColor: '#FFFFFF',
        paletteSlot: region.assignedId,
      );
    }

    // Build a default LevelDefinition
    final level = LevelDefinition(
      levelId: 'untitled',
      displayName: 'Untitled Level',
      world: 'forest',
      lineArt: 'untitled_lineart.png',
      regionMask: 'untitled_regionmask.png',
      regionCount: regions.length,
      difficulty: 'easy',
      regions: defs.values.toList(),
      hiddenEvents: const [],
      completionRewards: const RewardBundle(),
    );

    state = state.copyWith(
      overlayBytes: bytes,
      overlayImage: image,
      detectedRegions: regions,
      regionDefinitions: defs,
      levelDefinition: level,
      isDirty: true,
      statusMessage: '${regions.length} regions detected.',
    );
  }

  /// Select a region by its assigned ID.
  void selectRegion(int? regionId) {
    state = state.copyWith(
      selectedRegionId: () => regionId,
    );
  }

  /// Update level metadata fields.
  void updateMetadata({
    String? levelId,
    String? displayName,
    String? world,
    String? difficulty,
    List<String>? weatherSequence,
    RewardBundle? completionRewards,
  }) {
    if (state.levelDefinition == null) return;
    final level = state.levelDefinition!;

    final updated = LevelDefinition(
      levelId: levelId ?? level.levelId,
      displayName: displayName ?? level.displayName,
      world: world ?? level.world,
      lineArt: '${levelId ?? level.levelId}_lineart.png',
      regionMask: '${levelId ?? level.levelId}_regionmask.png',
      regionCount: level.regionCount,
      difficulty: difficulty ?? level.difficulty,
      regions: level.regions,
      hiddenEvents: level.hiddenEvents,
      completionRewards: completionRewards ?? level.completionRewards,
      weatherSequence: weatherSequence ?? level.weatherSequence,
    );

    state = state.copyWith(
      levelDefinition: updated,
      isDirty: true,
    );
  }

  /// Update a region's target color.
  void updateRegionColor(int regionId, String hexColor) {
    _updateRegion(regionId, (r) => RegionDefinition(
      id: r.id,
      targetColor: hexColor,
      paletteSlot: r.paletteSlot,
      onFillTriggers: r.onFillTriggers,
    ));
  }

  /// Update a region's palette slot.
  void updateRegionPaletteSlot(int regionId, int slot) {
    _updateRegion(regionId, (r) => RegionDefinition(
      id: r.id,
      targetColor: r.targetColor,
      paletteSlot: slot,
      onFillTriggers: r.onFillTriggers,
    ));
  }

  /// Add a trigger to a region.
  void addTrigger(int regionId, TriggerDefinition trigger) {
    _updateRegion(regionId, (r) => RegionDefinition(
      id: r.id,
      targetColor: r.targetColor,
      paletteSlot: r.paletteSlot,
      onFillTriggers: [...r.onFillTriggers, trigger],
    ));
  }

  /// Remove a trigger from a region by index.
  void removeTrigger(int regionId, int triggerIndex) {
    _updateRegion(regionId, (r) {
      final triggers = List<TriggerDefinition>.from(r.onFillTriggers);
      if (triggerIndex < triggers.length) triggers.removeAt(triggerIndex);
      return RegionDefinition(
        id: r.id,
        targetColor: r.targetColor,
        paletteSlot: r.paletteSlot,
        onFillTriggers: triggers,
      );
    });
  }

  /// Add a hidden event to the level.
  void addHiddenEvent(HiddenEventDefinition event) {
    if (state.levelDefinition == null) return;
    final level = state.levelDefinition!;
    final updated = LevelDefinition(
      levelId: level.levelId,
      displayName: level.displayName,
      world: level.world,
      lineArt: level.lineArt,
      regionMask: level.regionMask,
      regionCount: level.regionCount,
      difficulty: level.difficulty,
      regions: level.regions,
      hiddenEvents: [...level.hiddenEvents, event],
      completionRewards: level.completionRewards,
      weatherSequence: level.weatherSequence,
    );
    state = state.copyWith(levelDefinition: updated, isDirty: true);
  }

  /// Remove a hidden event by index.
  void removeHiddenEvent(int index) {
    if (state.levelDefinition == null) return;
    final level = state.levelDefinition!;
    final events = List<HiddenEventDefinition>.from(level.hiddenEvents);
    if (index < events.length) events.removeAt(index);
    final updated = LevelDefinition(
      levelId: level.levelId,
      displayName: level.displayName,
      world: level.world,
      lineArt: level.lineArt,
      regionMask: level.regionMask,
      regionCount: level.regionCount,
      difficulty: level.difficulty,
      regions: level.regions,
      hiddenEvents: events,
      completionRewards: level.completionRewards,
      weatherSequence: level.weatherSequence,
    );
    state = state.copyWith(levelDefinition: updated, isDirty: true);
  }

  /// Load an existing level definition (e.g., from a level.json import).
  void loadLevelDefinition(LevelDefinition level) {
    final defs = <int, RegionDefinition>{};
    for (final region in level.regions) {
      defs[region.id] = region;
    }
    state = state.copyWith(
      levelDefinition: level,
      regionDefinitions: defs,
      isDirty: false,
      statusMessage: 'Level "${level.displayName}" loaded.',
    );
  }

  /// Mark the project as saved (clears dirty flag).
  void markSaved() {
    state = state.copyWith(isDirty: false, statusMessage: 'Level exported.');
  }

  /// Helper: update a single region definition and sync it back into
  /// both the regionDefinitions map and the levelDefinition.regions list.
  void _updateRegion(
    int regionId,
    RegionDefinition Function(RegionDefinition) updater,
  ) {
    final existing = state.regionDefinitions[regionId];
    if (existing == null) return;

    final updated = updater(existing);
    final newDefs = Map<int, RegionDefinition>.from(state.regionDefinitions);
    newDefs[regionId] = updated;

    // Sync into levelDefinition.regions
    LevelDefinition? newLevel;
    if (state.levelDefinition != null) {
      final level = state.levelDefinition!;
      final regions = level.regions.map((r) {
        return r.id == regionId ? updated : r;
      }).toList();

      newLevel = LevelDefinition(
        levelId: level.levelId,
        displayName: level.displayName,
        world: level.world,
        lineArt: level.lineArt,
        regionMask: level.regionMask,
        regionCount: level.regionCount,
        difficulty: level.difficulty,
        regions: regions,
        hiddenEvents: level.hiddenEvents,
        completionRewards: level.completionRewards,
        weatherSequence: level.weatherSequence,
      );
    }

    state = state.copyWith(
      regionDefinitions: newDefs,
      levelDefinition: newLevel ?? state.levelDefinition,
      isDirty: true,
    );
  }
}

/// The global editor state provider.
final editorProvider =
    StateNotifierProvider<EditorNotifier, EditorState>((ref) {
  return EditorNotifier();
});
