import 'package:colorverse/models/models.dart';

/// A queued trigger event waiting for execution.
class _QueuedTrigger {
  final TriggerDefinition trigger;
  final int sourceRegionId;
  double delayRemaining; // seconds remaining before activation
  double elapsed; // seconds since activation started
  bool isCustomHandled; // managed externally via animationSpawner callback

  _QueuedTrigger({
    required this.trigger,
    required this.sourceRegionId,
    this.delayRemaining = 0,
  })  : elapsed = 0,
        isCustomHandled = false;
}

/// Callback signature for trigger execution.
typedef TriggerCallback = void Function(
  TriggerDefinition trigger,
  int sourceRegionId,
);

/// Callback for when a chain trigger should auto-fill a region.
typedef ChainFillCallback = void Function(
  int targetRegionId,
);

/// Callback signature for spawning a visual animation component.
typedef AnimationSpawner = void Function(
  AnimationTrigger trigger,
  int regionId,
  void Function() onComplete,
);

/// Callback signature for playing audio SFX.
typedef SfxPlayer = void Function(
  SfxTrigger trigger,
);

/// Concurrency-capped trigger queue from §6.
///
/// Manages the execution order of triggers fired by region fills.
/// Supports both custom playback callbacks (Rive + flame_audio) and stub timers.
class TriggerQueue {
  /// Maximum simultaneous animations (§6 spec: 8 default).
  final int concurrencyCap;

  /// Callback for when a trigger activates.
  final TriggerCallback? onTriggerActivated;

  /// Callback for when a trigger completes.
  final TriggerCallback? onTriggerCompleted;

  /// Callback for chain triggers that should auto-fill a region.
  final ChainFillCallback? onChainFill;

  /// Callback for spawning visual animation components (Rive/particle).
  final AnimationSpawner? animationSpawner;

  /// Callback for playing SFX sound effects.
  final SfxPlayer? sfxPlayer;

  /// Queue of pending triggers (waiting for activation).
  final List<_QueuedTrigger> _pending = [];

  /// Currently active (animating) triggers.
  final List<_QueuedTrigger> _active = [];

  /// Stub animation duration in seconds (used if animationSpawner is null).
  static const double _stubAnimDuration = 0.5;

  TriggerQueue({
    this.concurrencyCap = 8,
    this.onTriggerActivated,
    this.onTriggerCompleted,
    this.onChainFill,
    this.animationSpawner,
    this.sfxPlayer,
  });

  /// Number of triggers currently waiting.
  int get pendingCount => _pending.length;

  /// Number of triggers currently executing.
  int get activeCount => _active.length;

  /// Whether the queue is idle (nothing pending or active).
  bool get isIdle => _pending.isEmpty && _active.isEmpty;

  /// Enqueue triggers from a region fill event.
  ///
  /// Triggers are added in order. Chain triggers include a delay
  /// converted from milliseconds to seconds.
  void enqueue(List<TriggerDefinition> triggers, {required int regionId}) {
    for (final trigger in triggers) {
      final delay = switch (trigger) {
        ChainTrigger(:final delayMs) => delayMs / 1000.0,
        _ => 0.0,
      };

      _pending.add(_QueuedTrigger(
        trigger: trigger,
        sourceRegionId: regionId,
        delayRemaining: delay,
      ));
    }
  }

  /// Process the trigger queue — call from game loop's update().
  ///
  /// Activates queued triggers (up to concurrency cap) and advances
  /// active trigger timers.
  void update(double dt) {
    // 1. Advance active trigger timers for non-custom-handled triggers
    final completed = <_QueuedTrigger>[];
    for (final trigger in _active) {
      if (!trigger.isCustomHandled) {
        trigger.elapsed += dt;
        if (trigger.elapsed >= _stubAnimDuration) {
          completed.add(trigger);
        }
      }
    }

    // 2. Remove completed stub triggers
    for (final trigger in completed) {
      _active.remove(trigger);
      onTriggerCompleted?.call(trigger.trigger, trigger.sourceRegionId);
    }

    // 3. Tick down delays on pending triggers
    for (final trigger in _pending) {
      if (trigger.delayRemaining > 0) {
        trigger.delayRemaining -= dt;
        if (trigger.delayRemaining < 0) trigger.delayRemaining = 0;
      }
    }

    // 4. Activate pending triggers up to concurrency cap
    while (_active.length < concurrencyCap && _pending.isNotEmpty) {
      // Find the first trigger with no remaining delay
      final readyIndex =
          _pending.indexWhere((t) => t.delayRemaining <= 0);
      if (readyIndex < 0) break;

      final trigger = _pending.removeAt(readyIndex);

      switch (trigger.trigger) {
        case AnimationTrigger anim:
          if (animationSpawner != null) {
            trigger.isCustomHandled = true;
            _active.add(trigger);
            onTriggerActivated?.call(trigger.trigger, trigger.sourceRegionId);
            animationSpawner!(anim, trigger.sourceRegionId, () {
              _active.remove(trigger);
              onTriggerCompleted?.call(trigger.trigger, trigger.sourceRegionId);
            });
          } else {
            _active.add(trigger);
            onTriggerActivated?.call(trigger.trigger, trigger.sourceRegionId);
          }

        case SfxTrigger sfx:
          if (sfxPlayer != null) {
            sfxPlayer!(sfx);
            onTriggerActivated?.call(trigger.trigger, trigger.sourceRegionId);
            onTriggerCompleted?.call(trigger.trigger, trigger.sourceRegionId);
          } else {
            _active.add(trigger);
            onTriggerActivated?.call(trigger.trigger, trigger.sourceRegionId);
          }

        case ChainTrigger(:final targetRegionId):
          // Chain: fire immediately, no animation duration to wait for
          onChainFill?.call(targetRegionId);
          onTriggerCompleted?.call(trigger.trigger, trigger.sourceRegionId);
      }
    }
  }

  /// Clear all pending and active triggers.
  void clear() {
    _pending.clear();
    _active.clear();
  }
}
