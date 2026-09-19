import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'package:level_editor/editor/region_detector.dart';
import 'package:level_editor/editor/region_mask_encoder.dart';
import 'package:level_editor/utils/color_utils.dart';
import 'package:level_editor/utils/image_utils.dart';

void main() {
  group('RegionMaskEncoder', () {
    test('encodes regions with correct ID colors', () {
      // Create a simple overlay with 2 regions
      final overlay = img.Image(width: 10, height: 10, numChannels: 4);
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 10; x++) {
          overlay.setPixelRgba(x, y, 0, 0, 0, 0); // transparent
        }
      }
      // Region 1: red blob (2,2)-(4,4)
      for (var y = 2; y < 5; y++) {
        for (var x = 2; x < 5; x++) {
          overlay.setPixelRgba(x, y, 255, 0, 0, 255);
        }
      }
      // Region 2: blue blob (6,6)-(8,8)
      for (var y = 6; y < 9; y++) {
        for (var x = 6; x < 9; x++) {
          overlay.setPixelRgba(x, y, 0, 0, 255, 255);
        }
      }

      final regions = RegionDetector.detect(overlay);
      expect(regions.length, 2);

      // Encode
      final maskBytes = RegionMaskEncoder.encode(regions, 10, 10);

      // Decode and verify
      final mask = ImageUtils.decodePng(maskBytes);
      expect(mask.width, 10);
      expect(mask.height, 10);

      // Check a pixel from region 1 (should decode to ID 1)
      final px1 = ImageUtils.getPixel(mask, 3, 3);
      final id1 = ColorUtils.decodeRegionId(px1.r, px1.g, px1.b, px1.a);
      expect(id1, 1);

      // Check a pixel from region 2 (should decode to ID 2)
      final px2 = ImageUtils.getPixel(mask, 7, 7);
      final id2 = ColorUtils.decodeRegionId(px2.r, px2.g, px2.b, px2.a);
      expect(id2, 2);

      // Check a background pixel (should decode to ID 0)
      final pxBg = ImageUtils.getPixel(mask, 0, 0);
      final idBg = ColorUtils.decodeRegionId(pxBg.r, pxBg.g, pxBg.b, pxBg.a);
      expect(idBg, 0);
    });

    test('verify catches correctly encoded mask', () {
      final overlay = img.Image(width: 6, height: 6, numChannels: 4);
      for (var y = 0; y < 6; y++) {
        for (var x = 0; x < 6; x++) {
          overlay.setPixelRgba(x, y, 0, 0, 0, 0);
        }
      }
      // One small region
      for (var y = 1; y < 4; y++) {
        for (var x = 1; x < 4; x++) {
          overlay.setPixelRgba(x, y, 200, 100, 50, 255);
        }
      }

      final regions = RegionDetector.detect(overlay);
      final maskBytes = RegionMaskEncoder.encode(regions, 6, 6);
      final errors = RegionMaskEncoder.verify(maskBytes, regions);

      expect(errors, isEmpty);
    });

    test('encodes region IDs above 255 correctly', () {
      // Region with ID = 300 → green = 1, blue = 44
      final color = ColorUtils.encodeRegionId(300);
      expect((color.g * 255).round(), 1);
      expect((color.b * 255).round(), 44);

      // Round-trip
      final decoded = ColorUtils.decodeRegionId(
        (color.r * 255).round(),
        (color.g * 255).round(),
        (color.b * 255).round(),
        255,
      );
      expect(decoded, 300);
    });
  });

  group('ColorUtils', () {
    test('encodeRegionId and decodeRegionId round-trip', () {
      for (final id in [1, 10, 100, 255, 256, 500, 1000, 5000, 65535]) {
        final color = ColorUtils.encodeRegionId(id);
        final decoded = ColorUtils.decodeRegionId(
          (color.r * 255).round(),
          (color.g * 255).round(),
          (color.b * 255).round(),
          255,
        );
        expect(decoded, id, reason: 'Failed for ID $id');
      }
    });

    test('region ID 0 encodes to black', () {
      final color = ColorUtils.encodeRegionId(0);
      expect((color.r * 255).round(), 0);
      expect((color.g * 255).round(), 0);
      expect((color.b * 255).round(), 0);
    });

    test('transparent pixels decode to region 0', () {
      expect(ColorUtils.decodeRegionId(255, 100, 50, 0), 0);
      expect(ColorUtils.decodeRegionId(255, 100, 50, 50), 0);
    });

    test('hexToColor and colorToHex round-trip', () {
      expect(ColorUtils.colorToHex(ColorUtils.hexToColor('#3B7A45')), '#3B7A45');
      expect(ColorUtils.colorToHex(ColorUtils.hexToColor('#FF0000')), '#FF0000');
      expect(ColorUtils.colorToHex(ColorUtils.hexToColor('#000000')), '#000000');
    });
  });
}
