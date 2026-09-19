import 'dart:isolate';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// In-memory pixel buffer for O(1) region hit-testing.
///
/// Each level ships a hidden ID mask PNG where every region is
/// flood-filled with a unique color encoding its integer ID:
///   region ID n → RGB(0, n >> 8, n & 0xFF)
///
/// This buffer is decoded once per level load (in a background isolate)
/// and provides O(1) lookups: given image-space (x, y) coordinates,
/// return the region ID at that pixel.
///
/// See §5 of the spec for the full design rationale.
class RegionMaskBuffer {
  /// Width of the mask image in pixels.
  final int width;

  /// Height of the mask image in pixels.
  final int height;

  /// Raw RGBA pixel data. Each pixel is 4 bytes: R, G, B, A.
  final Uint8List _pixels;

  RegionMaskBuffer._({
    required this.width,
    required this.height,
    required Uint8List pixels,
  }) : _pixels = pixels;

  /// Decode a region mask PNG in a background isolate.
  ///
  /// This avoids blocking the UI thread — the `image` package does
  /// pure-Dart PNG decoding, which is safe to run in an isolate.
  ///
  /// Performance target: < 500ms for a 2048×2048 mask on mid-range hardware.
  static Future<RegionMaskBuffer> load(Uint8List pngBytes) async {
    final result = await Isolate.run(() => _decodeMask(pngBytes));
    return result;
  }

  /// Synchronous version for testing (no isolate).
  static RegionMaskBuffer loadSync(Uint8List pngBytes) {
    return _decodeMask(pngBytes);
  }

  /// Internal decode logic — runs in isolate.
  static RegionMaskBuffer _decodeMask(Uint8List pngBytes) {
    final image = img.decodePng(pngBytes);
    if (image == null) {
      throw ArgumentError('Failed to decode region mask PNG');
    }

    final width = image.width;
    final height = image.height;
    final pixels = Uint8List(width * height * 4);

    // Extract RGBA bytes from the decoded image
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final pixel = image.getPixel(x, y);
        final offset = (y * width + x) * 4;
        pixels[offset] = pixel.r.toInt();
        pixels[offset + 1] = pixel.g.toInt();
        pixels[offset + 2] = pixel.b.toInt();
        pixels[offset + 3] = pixel.a.toInt();
      }
    }

    return RegionMaskBuffer._(
      width: width,
      height: height,
      pixels: pixels,
    );
  }

  /// O(1) region ID lookup at image-space coordinates.
  ///
  /// Returns the region ID (1–65535) at the given pixel, or 0 for
  /// background/border pixels (black or transparent).
  ///
  /// Returns 0 if coordinates are out of bounds.
  int getRegionId(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return 0;

    final offset = (y * width + x) * 4;
    final r = _pixels[offset];
    final g = _pixels[offset + 1];
    final b = _pixels[offset + 2];
    final a = _pixels[offset + 3];

    // Transparent = no region
    if (a < 128) return 0;

    // Black = no region (border/background)
    if (r == 0 && g == 0 && b == 0) return 0;

    // Decode: green (high byte) + blue (low byte)
    return (g << 8) | b;
  }

  /// Check if coordinates are within the mask bounds.
  bool isInBounds(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }
}
