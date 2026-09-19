import 'package:colorverse/models/models.dart';
import 'package:colorverse/rendering/fill_state.dart';

/// Result of a hidden event firing.
class EventFireResult {
  /// The event definition that fired.
  final HiddenEventDefinition event;

  const EventFireResult({required this.event});
}

/// Evaluates hidden event conditions after every region fill.
///
/// Pure Dart — no Flame or Flutter dependency. Fully unit-testable.
///
/// Three condition types (from §7):
/// - `AllRegionsFilledCondition`: all listed regions must be filled
/// - `AnyRegionFilledCondition`: at least one listed region is filled
/// - `RegionFilledWithinTimeCondition`: all listed regions filled within a
///   time window starting from the first fill in the set
///
/// Events fire exactly once per level playthrough.
class HiddenEventEvaluator {
  /// All hidden events for this level.
  final List<HiddenEventDefinition> events;

  /// The fill state to check against.
  final FillState fillState;

  /// Events that have already fired (won't re-fire).
  final Set<String> _firedEventIds;

  /// Tracks when the first region in a timed-condition set was filled.
  /// Key: event ID, Value: elapsed game time (seconds) when first region
  /// in the set was filled.
  final Map<String, double> _timedEventStartTimes = {};

  /// Tracks when each region was filled (per-event).
  /// Key: event ID, Value: map of regionId → fill timestamp.
  final Map<String, Map<int, double>> _regionFillTimes = {};

  /// Total elapsed game time in seconds (accumulated via update()).
  double _elapsedSeconds = 0;

  HiddenEventEvaluator({
    required this.events,
    required this.fillState,
    Set<String>? alreadyFiredIds,
  }) : _firedEventIds = alreadyFiredIds ?? {};

  /// Set of event IDs that have already fired.
  Set<String> get firedEventIds => Set.unmodifiable(_firedEventIds);

  /// Whether a specific event has fired.
  bool hasFired(String eventId) => _firedEventIds.contains(eventId);

  /// Advance the internal timer. Call from game loop update().
  void update(double dt) {
    _elapsedSeconds += dt;
  }

  /// Evaluate all unfired events. Returns events whose conditions just
  /// became true. Call after every fill event.
  ///
  /// Each event fires at most once — subsequent calls return empty
  /// for already-fired events.
  List<EventFireResult> evaluate() {
    final results = <EventFireResult>[];

    for (final event in events) {
      // Skip already-fired events
      if (_firedEventIds.contains(event.id)) continue;

      final conditionMet = _evaluateCondition(event.id, event.condition);

      if (conditionMet) {
        _firedEventIds.add(event.id);
        results.add(EventFireResult(event: event));
      }
    }

    return results;
  }

  /// Evaluate a single condition.
  bool _evaluateCondition(String eventId, EventCondition condition) {
    return switch (condition) {
      AllRegionsFilledCondition(:final regionIds) =>
        _evaluateAllFilled(regionIds),
      AnyRegionFilledCondition(:final regionIds) =>
        _evaluateAnyFilled(regionIds),
      RegionFilledWithinTimeCondition(
        :final regionIds,
        :final timeLimitMs,
      ) =>
        _evaluateTimedFill(eventId, regionIds, timeLimitMs),
    };
  }

  /// All listed regions must be filled.
  bool _evaluateAllFilled(List<int> regionIds) {
    return regionIds.every((id) => fillState.isFilled(id));
  }

  /// At least one listed region must be filled.
  bool _evaluateAnyFilled(List<int> regionIds) {
    return regionIds.any((id) => fillState.isFilled(id));
  }

  /// All listed regions must be filled within [timeLimitMs] of the first
  /// fill in the set.
  bool _evaluateTimedFill(
    String eventId,
    List<int> regionIds,
    int timeLimitMs,
  ) {
    final timeLimitSec = timeLimitMs / 1000.0;

    // Track fill times for this event's regions
    final fillTimes = _regionFillTimes.putIfAbsent(eventId, () => {});

    // Record fill timestamps for newly filled regions
    for (final id in regionIds) {
      if (fillState.isFilled(id) && !fillTimes.containsKey(id)) {
        fillTimes[id] = _elapsedSeconds;
      }
    }

    // Check if all regions are filled
    final allFilled = regionIds.every((id) => fillState.isFilled(id));
    if (!allFilled) return false;

    // All filled — check if they were all filled within the time window.
    // The window starts from the earliest fill in this set.
    final timestamps = regionIds.map((id) => fillTimes[id]!);
    final earliest = timestamps.reduce((a, b) => a < b ? a : b);
    final latest = timestamps.reduce((a, b) => a > b ? a : b);

    if ((latest - earliest) <= timeLimitSec) {
      return true; // All filled within the time window
    }

    // Time window exceeded — reset all tracking for a fresh attempt
    _regionFillTimes.remove(eventId);
    return false;
  }

  /// Reset all state (for level restart).
  void reset() {
    _firedEventIds.clear();
    _timedEventStartTimes.clear();
    _regionFillTimes.clear();
    _elapsedSeconds = 0;
  }
}
