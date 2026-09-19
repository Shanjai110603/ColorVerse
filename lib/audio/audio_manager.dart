import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';

/// Centralized audio manager wrapping flame_audio.
///
/// Provides SFX and ambient music playback with asset preloading,
/// sound toggle controls, and graceful error fallbacks if audio files or
/// platform plugins are unavailable.
class AudioManager {
  /// Whether sound effects and music are globally enabled.
  bool soundEnabled;

  /// Cache of preloaded audio file names.
  final Set<String> _preloaded = {};

  AudioManager({this.soundEnabled = true});

  /// Preload a list of SFX asset paths.
  Future<void> preloadSfx(List<String> assets) async {
    if (!soundEnabled || assets.isEmpty) return;

    for (final asset in assets) {
      if (_preloaded.contains(asset)) continue;
      try {
        await FlameAudio.audioCache.load(asset);
        _preloaded.add(asset);
      } catch (e) {
        debugPrint('AudioManager: Warning - Failed to preload SFX asset "$asset": $e');
      }
    }
  }

  /// Play a one-shot sound effect.
  Future<void> playSfx(String asset) async {
    if (!soundEnabled || asset.isEmpty) return;

    try {
      await FlameAudio.play(asset);
    } catch (e) {
      debugPrint('AudioManager: Warning - Failed to play SFX "$asset": $e');
    }
  }

  /// Play background ambient music.
  Future<void> playAmbient(String asset, {double volume = 0.5}) async {
    if (!soundEnabled || asset.isEmpty) return;

    try {
      await FlameAudio.bgm.play(asset, volume: volume);
    } catch (e) {
      debugPrint('AudioManager: Warning - Failed to play ambient music "$asset": $e');
    }
  }

  /// Stop ambient music.
  Future<void> stopAmbient() async {
    try {
      await FlameAudio.bgm.stop();
    } catch (e) {
      debugPrint('AudioManager: Warning - Failed to stop ambient music: $e');
    }
  }

  /// Clear preloaded cache resources.
  void dispose() {
    _preloaded.clear();
    try {
      FlameAudio.bgm.dispose();
    } catch (_) {}
  }
}
