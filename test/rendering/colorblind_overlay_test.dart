import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:colorverse/rendering/colorblind_overlay.dart';

void main() {
  group('ColorblindSymbols', () {
    test('getIconForSlot maps slots 1..6 to unique distinct icons', () {
      final icons = <IconData>{};
      for (var slot = 1; slot <= 6; slot++) {
        final icon = ColorblindSymbols.getIconForSlot(slot);
        expect(icons.contains(icon), isFalse,
            reason: 'Icon for slot $slot should be unique');
        icons.add(icon);
      }
      expect(icons.length, 6);
    });

    test('getIconForSlot wraps around for slots > 6', () {
      final iconSlot1 = ColorblindSymbols.getIconForSlot(1);
      final iconSlot7 = ColorblindSymbols.getIconForSlot(7);
      expect(iconSlot7, equals(iconSlot1));
    });
  });
}
