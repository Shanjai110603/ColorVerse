import 'package:flutter/services.dart';

/// Centralized wrapper for in-game haptic feedback.
///
/// Respects the global [enabled] setting (from player profile settings).
class GameHaptics {
  GameHaptics._();

  /// Whether haptic feedback is globally enabled.
  static bool enabled = true;

  /// Light tap — played on successful region fill.
  static Future<void> lightTap() async {
    if (!enabled) return;
    await HapticFeedback.lightImpact();
  }

  /// Medium tap — played on wrong palette selection or invalid tap.
  static Future<void> mediumTap() async {
    if (!enabled) return;
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact — played on level completion or major reward reveal.
  static Future<void> heavyImpact() async {
    if (!enabled) return;
    await HapticFeedback.heavyImpact();
  }

  /// Selection click — played on UI button / palette slot selection.
  static Future<void> selectionClick() async {
    if (!enabled) return;
    await HapticFeedback.selectionClick();
  }
}
