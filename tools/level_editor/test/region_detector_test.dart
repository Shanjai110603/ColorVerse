import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import 'package:level_editor/editor/region_detector.dart';

void main() {
  group('RegionDetector', () {
    test('detects a single solid-color region', () {
      // Create a 10x10 image: all red except black border
      final image = img.Image(width: 10, height: 10, numChannels: 4);
      // Fill with black (border)
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 10; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 255);
        }
      }
      // Fill interior (2,2)-(7,7) with red
      for (var y = 2; y < 8; y++) {
        for (var x = 2; x < 8; x++) {
          image.setPixelRgba(x, y, 255, 0, 0, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      expect(regions.length, 1);
      expect(regions[0].assignedId, 1);
      expect(regions[0].pixels.length, 36); // 6x6 interior
    });

    test('detects multiple distinct-color regions', () {
      // Create a 20x10 image with two colored regions separated by black
      final image = img.Image(width: 20, height: 10, numChannels: 4);
      // Fill with black
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 20; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 255);
        }
      }
      // Left region: green (2,2)-(7,7)
      for (var y = 2; y < 8; y++) {
        for (var x = 2; x < 8; x++) {
          image.setPixelRgba(x, y, 0, 200, 0, 255);
        }
      }
      // Right region: blue (12,2)-(17,7)
      for (var y = 2; y < 8; y++) {
        for (var x = 12; x < 18; x++) {
          image.setPixelRgba(x, y, 0, 0, 200, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      expect(regions.length, 2);
      expect(regions[0].assignedId, 1);
      expect(regions[1].assignedId, 2);
      // Both should have 36 pixels (6x6)
      expect(regions[0].pixels.length, 36);
      expect(regions[1].pixels.length, 36);
    });

    test('ignores transparent pixels', () {
      final image = img.Image(width: 10, height: 10, numChannels: 4);
      // Fill with transparent
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 10; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 0);
        }
      }
      // Small red region at (3,3)-(5,5)
      for (var y = 3; y < 6; y++) {
        for (var x = 3; x < 6; x++) {
          image.setPixelRgba(x, y, 255, 0, 0, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      expect(regions.length, 1);
      expect(regions[0].pixels.length, 9); // 3x3
    });

    test('computes correct centroid', () {
      final image = img.Image(width: 10, height: 10, numChannels: 4);
      // All transparent
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 10; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 0);
        }
      }
      // Region at (2,2)-(5,5) → centroid should be (3.5, 3.5)
      for (var y = 2; y < 6; y++) {
        for (var x = 2; x < 6; x++) {
          image.setPixelRgba(x, y, 100, 150, 200, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      expect(regions.length, 1);
      expect(regions[0].centroid.dx, closeTo(3.5, 0.01));
      expect(regions[0].centroid.dy, closeTo(3.5, 0.01));
    });

    test('computes correct bounding box', () {
      final image = img.Image(width: 20, height: 20, numChannels: 4);
      for (var y = 0; y < 20; y++) {
        for (var x = 0; x < 20; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 0);
        }
      }
      // Region at (5,3)-(12,9)
      for (var y = 3; y < 10; y++) {
        for (var x = 5; x < 13; x++) {
          image.setPixelRgba(x, y, 200, 100, 50, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      expect(regions.length, 1);
      expect(regions[0].boundingBox.left, 5);
      expect(regions[0].boundingBox.top, 3);
      expect(regions[0].boundingBox.right, 13); // exclusive
      expect(regions[0].boundingBox.bottom, 10);
    });

    test('detects two regions of the same color separated by black', () {
      final image = img.Image(width: 20, height: 10, numChannels: 4);
      // Fill black
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 20; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 255);
        }
      }
      // Two red blobs separated by black column at x=9
      for (var y = 2; y < 8; y++) {
        for (var x = 2; x < 8; x++) {
          image.setPixelRgba(x, y, 255, 0, 0, 255);
        }
      }
      for (var y = 2; y < 8; y++) {
        for (var x = 12; x < 18; x++) {
          image.setPixelRgba(x, y, 255, 0, 0, 255);
        }
      }

      final regions = RegionDetector.detect(image);

      // Should detect 2 separate regions even though same color
      expect(regions.length, 2);
      expect(regions[0].pixels.length, 36);
      expect(regions[1].pixels.length, 36);
    });

    test('returns empty list for all-black image', () {
      final image = img.Image(width: 10, height: 10, numChannels: 4);
      for (var y = 0; y < 10; y++) {
        for (var x = 0; x < 10; x++) {
          image.setPixelRgba(x, y, 0, 0, 0, 255);
        }
      }

      final regions = RegionDetector.detect(image);
      expect(regions, isEmpty);
    });
  });
}
