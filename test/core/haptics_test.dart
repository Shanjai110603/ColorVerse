import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/core/haptics.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GameHaptics', () {
    test('enabled toggle works correctly', () async {
      GameHaptics.enabled = true;
      expect(GameHaptics.enabled, isTrue);

      // Should run without throwing when enabled
      await GameHaptics.lightTap();
      await GameHaptics.mediumTap();
      await GameHaptics.heavyImpact();
      await GameHaptics.selectionClick();

      GameHaptics.enabled = false;
      expect(GameHaptics.enabled, isFalse);

      // Should safely no-op when disabled
      await GameHaptics.lightTap();
      await GameHaptics.mediumTap();
      await GameHaptics.heavyImpact();
      await GameHaptics.selectionClick();
    });
  });
}
