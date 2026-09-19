import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/animations/trigger_queue.dart';
import 'package:colorverse/models/models.dart';

void main() {
  group('TriggerQueue', () {
    test('starts idle', () {
      final queue = TriggerQueue();
      expect(queue.isIdle, isTrue);
      expect(queue.pendingCount, 0);
      expect(queue.activeCount, 0);
    });

    test('enqueue adds triggers to pending', () {
      final queue = TriggerQueue();
      queue.enqueue([
        const TriggerDefinition.animation(
            asset: 'anim.riv', anchor: 'centroid'),
        const TriggerDefinition.sfx(asset: 'sound.ogg'),
      ], regionId: 1);

      expect(queue.pendingCount, 2);
      expect(queue.isIdle, isFalse);
    });

    test('update activates animation and sfx triggers up to cap', () {
      int activated = 0;
      final queue = TriggerQueue(
        concurrencyCap: 2,
        onTriggerActivated: (_, _) => activated++,
      );

      queue.enqueue([
        const TriggerDefinition.animation(
            asset: 'a.riv', anchor: 'centroid'),
        const TriggerDefinition.sfx(asset: 's.ogg'),
        const TriggerDefinition.animation(
            asset: 'b.riv', anchor: 'centroid'),
      ], regionId: 1);

      queue.update(0.016); // one frame

      // Cap is 2, so only 2 should be active
      expect(queue.activeCount, 2);
      expect(queue.pendingCount, 1);
      expect(activated, 2);
    });

    test('update completes stub triggers after duration', () {
      int completed = 0;
      final queue = TriggerQueue(
        onTriggerCompleted: (_, _) => completed++,
      );

      queue.enqueue([
        const TriggerDefinition.animation(
            asset: 'a.riv', anchor: 'centroid'),
      ], regionId: 1);

      queue.update(0.1); // activate
      expect(queue.activeCount, 1);

      queue.update(0.5); // enough to complete stub (0.5s duration)
      expect(queue.activeCount, 0);
      expect(completed, 1);
      expect(queue.isIdle, isTrue);
    });

    test('chain trigger fires callback immediately', () {
      int chainFired = 0;
      int chainTargetId = 0;

      final queue = TriggerQueue(
        onChainFill: (targetId) {
          chainFired++;
          chainTargetId = targetId;
        },
      );

      queue.enqueue([
        const TriggerDefinition.chain(targetRegionId: 42, delayMs: 0),
      ], regionId: 1);

      queue.update(0.016);

      expect(chainFired, 1);
      expect(chainTargetId, 42);
      expect(queue.isIdle, isTrue); // chain has no animation duration
    });

    test('chain trigger with delay waits before firing', () {
      int chainFired = 0;
      final queue = TriggerQueue(
        onChainFill: (_) => chainFired++,
      );

      queue.enqueue([
        // 800ms delay
        const TriggerDefinition.chain(targetRegionId: 5, delayMs: 800),
      ], regionId: 1);

      queue.update(0.016); // 16ms — not enough
      expect(chainFired, 0);

      queue.update(0.5); // 500ms total — not enough
      expect(chainFired, 0);

      queue.update(0.4); // 900ms total — past 800ms threshold
      expect(chainFired, 1);
    });

    test('clear empties all pending and active triggers', () {
      final queue = TriggerQueue();
      queue.enqueue([
        const TriggerDefinition.animation(
            asset: 'a.riv', anchor: 'centroid'),
        const TriggerDefinition.sfx(asset: 's.ogg'),
      ], regionId: 1);

      queue.update(0.016);
      expect(queue.activeCount, 2);

      queue.clear();
      expect(queue.pendingCount, 0);
      expect(queue.activeCount, 0);
      expect(queue.isIdle, isTrue);
    });

    test('respects concurrencyCap', () {
      int activated = 0;
      final queue = TriggerQueue(
        concurrencyCap: 3,
        onTriggerActivated: (_, _) => activated++,
      );

      // Enqueue 5 triggers
      queue.enqueue(List.generate(
        5,
        (i) => TriggerDefinition.animation(
            asset: 'a$i.riv', anchor: 'centroid'),
      ), regionId: 1);

      queue.update(0.016);

      expect(queue.activeCount, 3); // capped at 3
      expect(queue.pendingCount, 2); // 2 still waiting
      expect(activated, 3);
    });
  });
}
