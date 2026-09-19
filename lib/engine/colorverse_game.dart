import 'dart:typed_data';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:colorverse/animations/hidden_event_evaluator.dart';
import 'package:colorverse/animations/trigger_effect_component.dart';
import 'package:colorverse/animations/trigger_queue.dart';
import 'package:colorverse/audio/audio_manager.dart';
import 'package:colorverse/coloring/fill_controller.dart';
import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/colorblind_overlay.dart';
import 'package:colorverse/rendering/fill_state.dart';
import 'package:colorverse/rendering/line_art_component.dart';
import 'package:colorverse/rendering/region_mask_buffer.dart';
import 'package:colorverse/rendering/region_overlay_component.dart';

/// Callback for notifying the Flutter UI layer of game events.
typedef GameEventCallback = void Function(
    String event, Map<String, dynamic> data);

/// Callback for persisting a region fill event to SQLite / Drift.
typedef PersistenceCallback = Future<void> Function(int regionId);

/// The top-level Flame game class for ColorVerse.
///
/// Manages the rendering stack (line art → region overlay → colorblind symbols → animations),
/// processes tap events via O(1) mask lookup, and orchestrates the
/// fill + trigger + hidden-event pipeline.
class ColorVerseGame extends FlameGame with TapCallbacks, ScaleDetector {
  /// The level being played.
  final LevelDefinition level;

  /// O(1) hit-testing buffer.
  final RegionMaskBuffer maskBuffer;

  /// Visual fill state.
  final FillState fillState;

  /// Fill validation + logic.
  final FillController fillController;

  /// Trigger execution queue.
  late final TriggerQueue triggerQueue;

  /// Hidden event evaluator.
  final HiddenEventEvaluator hiddenEventEvaluator;

  /// Audio manager for SFX and background music.
  final AudioManager audioManager;

  /// Currently selected palette slot.
  int selectedPaletteSlot;

  /// Callback for game events (fill, complete, hiddenEvent, error).
  GameEventCallback? onGameEvent;

  /// Callback for persisting region fill state immediately.
  PersistenceCallback? onPersistFill;

  /// The region overlay component.
  late RegionOverlayComponent _regionOverlay;

  /// Colorblind pattern overlay component.
  late ColorblindOverlayComponent _colorblindOverlay;

  bool _colorblindMode = false;

  /// Line art image bytes.
  final Uint8List _lineArtBytes;

  ColorVerseGame({
    required this.level,
    required this.maskBuffer,
    required this.fillState,
    required this.fillController,
    required this.hiddenEventEvaluator,
    required Uint8List lineArtBytes,
    AudioManager? audioManager,
    this.selectedPaletteSlot = 1,
    bool colorblindMode = false,
  })  : audioManager = audioManager ?? AudioManager(),
        _colorblindMode = colorblindMode,
        _lineArtBytes = lineArtBytes {
    // Wire up trigger queue with chain auto-fill, animation spawner, and sfx player
    triggerQueue = TriggerQueue(
      concurrencyCap: 8,
      onChainFill: _autoFillChain,
      animationSpawner: _spawnAnimationTrigger,
      sfxPlayer: (sfx) => this.audioManager.playSfx(sfx.asset),
    );
  }

  /// Toggle colorblind mode pattern symbols.
  bool get colorblindMode => _colorblindMode;
  set colorblindMode(bool enabled) {
    _colorblindMode = enabled;
    _colorblindOverlay.enabled = enabled;
  }

  @override
  Future<void> onLoad() async {
    // Create line art component
    final lineArt = await LineArtComponent.fromBytes(_lineArtBytes);

    // Create region overlay
    _regionOverlay = RegionOverlayComponent(
      maskBuffer: maskBuffer,
      fillState: fillState,
    );

    // Create colorblind overlay
    _colorblindOverlay = ColorblindOverlayComponent(
      maskBuffer: maskBuffer,
      fillState: fillState,
      fillController: fillController,
      enabled: _colorblindMode,
    );

    // Add to world in rendering order (bottom → top)
    world.add(lineArt);
    world.add(_regionOverlay);
    world.add(_colorblindOverlay);

    // Configure camera to frame the full level
    final levelWidth = maskBuffer.width.toDouble();
    final levelHeight = maskBuffer.height.toDouble();
    camera.viewfinder.visibleGameSize = Vector2(levelWidth, levelHeight);
    camera.viewfinder.position = Vector2(levelWidth / 2, levelHeight / 2);
    camera.viewfinder.anchor = Anchor.center;
  }

  /// Spawn an animation component (Rive / particle ripple) at region centroid.
  void _spawnAnimationTrigger(
    AnimationTrigger trigger,
    int regionId,
    void Function() onComplete,
  ) {
    final centroid = _calculateRegionCentroid(regionId);
    final effect = TriggerEffectComponent(
      asset: trigger.asset,
      position: centroid,
      onComplete: onComplete,
    );
    world.add(effect);
  }

  /// Helper calculating centroid position for a region.
  Vector2 _calculateRegionCentroid(int regionId) {
    var sumX = 0;
    var sumY = 0;
    var count = 0;

    for (var y = 0; y < maskBuffer.height; y += 4) {
      for (var x = 0; x < maskBuffer.width; x += 4) {
        if (maskBuffer.getRegionId(x, y) == regionId) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }

    if (count == 0) return Vector2(maskBuffer.width / 2, maskBuffer.height / 2);
    return Vector2(sumX / count, sumY / count);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // 1. Convert screen → world coords via camera
    final worldPos =
        camera.viewfinder.transform.globalToLocal(event.canvasPosition);

    // 2. O(1) region ID lookup
    final regionId = maskBuffer.getRegionId(
      worldPos.x.toInt(),
      worldPos.y.toInt(),
    );
    if (regionId == 0) return;

    // 3. Process the fill
    final result =
        fillController.processRegionTap(regionId, selectedPaletteSlot);

    if (result.isSuccess) {
      _onFillSuccess(regionId, result);
    } else {
      onGameEvent?.call('fillFailed', {
        'regionId': regionId,
        'reason': result.type.name,
      });
    }
  }

  /// Handle a successful region fill (from player tap or chain auto-fill).
  void _onFillSuccess(int regionId, FillResult result) {
    // 1. Update visual overlay
    final color = fillState.getColor(regionId);
    if (color != null) _regionOverlay.onRegionFilled(regionId, color);

    // 2. Persist fill state immediately (crash resilience / mid-level resume)
    onPersistFill?.call(regionId);

    // 3. Enqueue triggers (may include chain triggers)
    if (result.triggers.isNotEmpty) {
      triggerQueue.enqueue(result.triggers, regionId: regionId);
    }

    // 4. Evaluate hidden events after this fill
    final firedEvents = hiddenEventEvaluator.evaluate();
    for (final fired in firedEvents) {
      onGameEvent?.call('hiddenEvent', {
        'eventId': fired.event.id,
        'reveal': fired.event.reveal,
      });
    }

    // 5. Notify Flutter UI of fill
    onGameEvent?.call('fill', {
      'regionId': regionId,
      'filledCount': fillController.filledRegions,
      'totalCount': fillController.totalRegions,
      'isComplete': fillController.isComplete,
    });

    // 6. Check level completion
    if (fillController.isComplete) {
      onGameEvent?.call('complete', {
        'levelId': level.levelId,
        'rewards': level.completionRewards.toJson(),
      });
    }
  }

  /// Auto-fill a region triggered by a chain (not a player tap).
  ///
  /// Uses the target region's own palette slot so chains always succeed
  /// regardless of the player's current palette selection.
  /// Already-filled regions are naturally skipped (FillController returns
  /// `alreadyFilled`), preventing infinite A→B→A loops.
  void _autoFillChain(int targetRegionId) {
    final region = fillController.getRegion(targetRegionId);
    if (region == null) return; // guard: invalid chain target

    // Use the region's own palette slot — chains are deterministic
    final result = fillController.processRegionTap(
      targetRegionId,
      region.paletteSlot,
    );

    if (result.isSuccess) {
      _onFillSuccess(targetRegionId, result);
    }
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    // Pinch-to-zoom
    if (info.pointerCount >= 2) {
      final zoomDelta = info.scale.global.y;
      camera.viewfinder.zoom =
          (camera.viewfinder.zoom * zoomDelta).clamp(0.5, 5.0);
    } else {
      // Single-finger pan
      final delta = info.delta.global;
      camera.viewfinder.position -= delta / camera.viewfinder.zoom;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    triggerQueue.update(dt);
    hiddenEventEvaluator.update(dt);
  }
}
