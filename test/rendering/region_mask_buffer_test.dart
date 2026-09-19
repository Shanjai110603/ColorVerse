import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'package:colorverse/rendering/region_mask_buffer.dart';

/// Helper: create a synthetic mask PNG with regions encoded as ID colors.
/// Region n → RGB(0, n >> 8, n & 0xFF)
Uint8List _makeMaskPng({
  int width = 10,
  int height = 10,
  Map<(int, int, int, int), int> regionRects = const {},
  // rect: (x1, y1, x2, y2) → regionId
}) {
  final image = img.Image(width: width, height: height, numChannels: 4);

  // Fill background with black
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      image.setPixelRgba(x, y, 0, 0, 0, 255);
    }
  }

  // Paint each region
  for (final entry in regionRects.entries) {
    final (x1, y1, x2, y2) = entry.key;
    final regionId = entry.value;
    final g = (regionId >> 8) & 0xFF;
    final b = regionId & 0xFF;
    for (var y = y1; y < y2; y++) {
      for (var x = x1; x < x2; x++) {
        image.setPixelRgba(x, y, 0, g, b, 255);
      }
    }
  }

  return Uint8List.fromList(img.encodePng(image));
}

void main() {
  group('RegionMaskBuffer', () {
    test('loadSync decodes a single-region mask correctly', () {
      final pngBytes = _makeMaskPng(
        regionRects: {(2, 2, 7, 7): 1},
      );

      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.width, 10);
      expect(buffer.height, 10);

      // Interior pixels should be region 1
      expect(buffer.getRegionId(3, 3), 1);
      expect(buffer.getRegionId(5, 5), 1);
      expect(buffer.getRegionId(6, 6), 1);

      // Border pixels should be region 0
      expect(buffer.getRegionId(0, 0), 0);
      expect(buffer.getRegionId(9, 9), 0);
    });

    test('loadSync decodes multiple regions correctly', () {
      final pngBytes = _makeMaskPng(
        width: 20,
        height: 10,
        regionRects: {
          (0, 0, 9, 10): 1,   // left half = region 1
          (11, 0, 20, 10): 2, // right half = region 2
          // column 9-10 stays black = background
        },
      );

      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.getRegionId(4, 5), 1);
      expect(buffer.getRegionId(15, 5), 2);
      expect(buffer.getRegionId(10, 5), 0); // black border
    });

    test('returns 0 for out-of-bounds coordinates', () {
      final pngBytes = _makeMaskPng(regionRects: {(2, 2, 7, 7): 1});
      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.getRegionId(-1, 0), 0);
      expect(buffer.getRegionId(0, -1), 0);
      expect(buffer.getRegionId(100, 0), 0);
      expect(buffer.getRegionId(0, 100), 0);
    });

    test('supports region IDs above 255 (encoded in g + b channels)', () {
      // Region ID 300: g = 300 >> 8 = 1, b = 300 & 0xFF = 44
      final image = img.Image(width: 5, height: 5, numChannels: 4);
      for (var y = 0; y < 5; y++) {
        for (var x = 0; x < 5; x++) {
          image.setPixelRgba(x, y, 0, 1, 44, 255); // region 300
        }
      }
      final pngBytes = Uint8List.fromList(img.encodePng(image));
      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.getRegionId(2, 2), 300);
    });

    test('returns 0 for fully transparent pixels', () {
      final image = img.Image(width: 5, height: 5, numChannels: 4);
      for (var y = 0; y < 5; y++) {
        for (var x = 0; x < 5; x++) {
          image.setPixelRgba(x, y, 100, 100, 100, 0); // transparent
        }
      }
      final pngBytes = Uint8List.fromList(img.encodePng(image));
      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.getRegionId(2, 2), 0);
    });

    test('isInBounds returns correct results', () {
      final pngBytes = _makeMaskPng(width: 10, height: 20);
      final buffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(buffer.isInBounds(0, 0), isTrue);
      expect(buffer.isInBounds(9, 19), isTrue);
      expect(buffer.isInBounds(10, 0), isFalse);
      expect(buffer.isInBounds(0, 20), isFalse);
      expect(buffer.isInBounds(-1, 0), isFalse);
    });

    test('load() async version returns same result as loadSync()', () async {
      final pngBytes = _makeMaskPng(regionRects: {(1, 1, 4, 4): 5});

      final asyncBuffer = await RegionMaskBuffer.load(pngBytes);
      final syncBuffer = RegionMaskBuffer.loadSync(pngBytes);

      expect(asyncBuffer.getRegionId(2, 2), syncBuffer.getRegionId(2, 2));
      expect(asyncBuffer.getRegionId(0, 0), syncBuffer.getRegionId(0, 0));
      expect(asyncBuffer.width, syncBuffer.width);
      expect(asyncBuffer.height, syncBuffer.height);
    });
  });
}
