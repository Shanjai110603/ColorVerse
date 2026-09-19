import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/audio/audio_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Mock channel for audioplayers global scope in unit tests
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      (MethodCall methodCall) async {
        return null;
      },
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      (MethodCall methodCall) async {
        return null;
      },
    );
  });

  group('AudioManager', () {
    test('soundEnabled toggle works correctly', () async {
      final manager = AudioManager(soundEnabled: true);
      expect(manager.soundEnabled, isTrue);

      // Call playSfx with mock channel registered
      await manager.playSfx('non_existent.ogg');

      manager.soundEnabled = false;
      expect(manager.soundEnabled, isFalse);

      // Safely no-ops when disabled
      await manager.playSfx('non_existent.ogg');
      await manager.preloadSfx(['sample.ogg']);
      await manager.playAmbient('bgm.ogg');
      await manager.stopAmbient();

      manager.dispose();
    });
  });
}
