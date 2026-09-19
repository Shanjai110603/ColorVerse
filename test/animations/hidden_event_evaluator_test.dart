import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/animations/hidden_event_evaluator.dart';
import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/fill_state.dart';

void main() {
  group('HiddenEventEvaluator', () {
    group('AllRegionsFilledCondition', () {
      test('fires when all listed regions are filled', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.allRegionsFilled(regionIds: [1, 2, 3]),
              reveal: EventReveal.spriteReveal(
                  asset: 'star.png', position: [0.5, 0.5]),
            ),
          ],
          fillState: fillState,
        );

        // Fill only 2 of 3
        fillState.markFilled(1, const Color(0xFFFF0000));
        fillState.markFilled(2, const Color(0xFF00FF00));
        expect(evaluator.evaluate(), isEmpty);

        // Fill the last one
        fillState.markFilled(3, const Color(0xFF0000FF));
        final results = evaluator.evaluate();
        expect(results.length, 1);
        expect(results.first.event.id, 'evt1');
      });

      test('does not fire when only some regions are filled', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.allRegionsFilled(regionIds: [1, 2]),
              reveal: EventReveal.spriteReveal(
                  asset: 'a.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
        );

        fillState.markFilled(1, const Color(0xFFFF0000));
        expect(evaluator.evaluate(), isEmpty);
      });
    });

    group('AnyRegionFilledCondition', () {
      test('fires when first region is filled', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt2',
              condition:
                  EventCondition.anyRegionFilled(regionIds: [10, 20, 30]),
              reveal: EventReveal.spriteReveal(
                  asset: 'b.png', position: [0.5, 0.5]),
            ),
          ],
          fillState: fillState,
        );

        fillState.markFilled(20, const Color(0xFFFF0000));
        final results = evaluator.evaluate();
        expect(results.length, 1);
        expect(results.first.event.id, 'evt2');
      });

      test('does not fire when no listed regions are filled', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt2',
              condition: EventCondition.anyRegionFilled(regionIds: [10, 20]),
              reveal: EventReveal.spriteReveal(
                  asset: 'b.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
        );

        // Fill a region NOT in the list
        fillState.markFilled(99, const Color(0xFFFF0000));
        expect(evaluator.evaluate(), isEmpty);
      });
    });

    group('RegionFilledWithinTimeCondition', () {
      test('fires when all regions filled within time limit', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt3',
              condition: EventCondition.regionFilledWithinTime(
                regionIds: [1, 2],
                timeLimitMs: 5000,
              ),
              reveal: EventReveal.spriteReveal(
                  asset: 'c.png', position: [0.5, 0.5]),
            ),
          ],
          fillState: fillState,
        );

        // Simulate 1 second passing
        evaluator.update(1.0);

        // Fill first region
        fillState.markFilled(1, const Color(0xFFFF0000));
        expect(evaluator.evaluate(), isEmpty); // not all filled yet

        // Simulate 2 more seconds (3s total)
        evaluator.update(2.0);

        // Fill second region (within 5s window)
        fillState.markFilled(2, const Color(0xFF00FF00));
        final results = evaluator.evaluate();
        expect(results.length, 1);
        expect(results.first.event.id, 'evt3');
      });

      test('does not fire when time limit expires before all filled', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt3',
              condition: EventCondition.regionFilledWithinTime(
                regionIds: [1, 2],
                timeLimitMs: 2000, // 2 seconds
              ),
              reveal: EventReveal.spriteReveal(
                  asset: 'c.png', position: [0.5, 0.5]),
            ),
          ],
          fillState: fillState,
        );

        // Fill first region
        fillState.markFilled(1, const Color(0xFFFF0000));
        evaluator.evaluate(); // start timer

        // Wait too long
        evaluator.update(3.0); // 3s > 2s limit

        // Now fill second (too late)
        fillState.markFilled(2, const Color(0xFF00FF00));
        // Timer resets on expiry since not all were filled
        expect(evaluator.evaluate(), isEmpty);
      });
    });

    group('fire-once semantics', () {
      test('event does not re-fire after being triggered', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.anyRegionFilled(regionIds: [1]),
              reveal: EventReveal.spriteReveal(
                  asset: 'a.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
        );

        fillState.markFilled(1, const Color(0xFFFF0000));
        final first = evaluator.evaluate();
        expect(first.length, 1);

        // Second evaluation — should not fire again
        final second = evaluator.evaluate();
        expect(second, isEmpty);
        expect(evaluator.hasFired('evt1'), isTrue);
      });

      test('alreadyFiredIds skips pre-fired events', () {
        final fillState = FillState();
        fillState.markFilled(1, const Color(0xFFFF0000));

        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.anyRegionFilled(regionIds: [1]),
              reveal: EventReveal.spriteReveal(
                  asset: 'a.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
          alreadyFiredIds: {'evt1'},
        );

        // Even though condition is met, it was already fired
        expect(evaluator.evaluate(), isEmpty);
      });
    });

    group('multiple events', () {
      test('evaluates all events and fires eligible ones', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.anyRegionFilled(regionIds: [1]),
              reveal: EventReveal.spriteReveal(
                  asset: 'a.png', position: [0, 0]),
            ),
            const HiddenEventDefinition(
              id: 'evt2',
              condition: EventCondition.allRegionsFilled(regionIds: [1, 2]),
              reveal: EventReveal.spriteReveal(
                  asset: 'b.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
        );

        // Fill region 1 — evt1 fires (any), evt2 doesn't (needs 1+2)
        fillState.markFilled(1, const Color(0xFFFF0000));
        final first = evaluator.evaluate();
        expect(first.length, 1);
        expect(first.first.event.id, 'evt1');

        // Fill region 2 — evt2 fires now
        fillState.markFilled(2, const Color(0xFF00FF00));
        final second = evaluator.evaluate();
        expect(second.length, 1);
        expect(second.first.event.id, 'evt2');
      });
    });

    group('reset', () {
      test('reset clears fired state and timers', () {
        final fillState = FillState();
        final evaluator = HiddenEventEvaluator(
          events: [
            const HiddenEventDefinition(
              id: 'evt1',
              condition: EventCondition.anyRegionFilled(regionIds: [1]),
              reveal: EventReveal.spriteReveal(
                  asset: 'a.png', position: [0, 0]),
            ),
          ],
          fillState: fillState,
        );

        fillState.markFilled(1, const Color(0xFFFF0000));
        evaluator.evaluate(); // fire
        expect(evaluator.hasFired('evt1'), isTrue);

        evaluator.reset();
        expect(evaluator.hasFired('evt1'), isFalse);

        // Can fire again after reset
        final results = evaluator.evaluate();
        expect(results.length, 1);
      });
    });
  });
}
