import 'dart:typed_data';

import 'package:image/image.dart' as img;

/// Utilities for loading and manipulating images using the pure-Dart
/// `image` package. This avoids any dependency on `dart:ui` which
/// isn't available in headless tests or background isolates.
class ImageUtils {
  ImageUtils._();

  /// Decode a PNG file's bytes into an [img.Image].
  static img.Image decodePng(Uint8List bytes) {
    final decoded = img.decodePng(bytes);
    if (decoded == null) {
      throw ArgumentError('Failed to decode PNG image');
    }
    return decoded;
  }

  /// Encode an [img.Image] to PNG bytes.
  static Uint8List encodePng(img.Image image) {
    return Uint8List.fromList(img.encodePng(image));
  }

  /// Get the RGBA values of a pixel at (x, y) from an [img.Image].
  /// Returns a record of (r, g, b, a) as integers 0–255.
  static ({int r, int g, int b, int a}) getPixel(
      img.Image image, int x, int y) {
    final pixel = image.getPixel(x, y);
    return (
      r: pixel.r.toInt(),
      g: pixel.g.toInt(),
      b: pixel.b.toInt(),
      a: pixel.a.toInt(),
    );
  }

  /// Set the RGBA values of a pixel at (x, y) in an [img.Image].
  static void setPixel(
      img.Image image, int x, int y, int r, int g, int b, int a) {
    image.setPixelRgba(x, y, r, g, b, a);
  }

  /// Create a new RGBA image of the given dimensions, filled with transparent black.
  static img.Image createImage(int width, int height) {
    return img.Image(width: width, height: height, numChannels: 4);
  }
}
