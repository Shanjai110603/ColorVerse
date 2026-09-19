import 'dart:typed_data';

import '../utils/color_utils.dart';
import '../utils/image_utils.dart';
import 'region_detector.dart';

/// Re-encodes detected regions into a runtime-compatible ID mask PNG.
///
/// The output image has the same dimensions as the source overlay.
/// Each region's pixels are flat-filled with the region's encoded ID color:
///   region ID n → RGB(0, n >> 8, n & 0xFF)
///
/// Background/border pixels are encoded as RGB(0, 0, 0) = region ID 0.
///
/// This mask is used at runtime for O(1) tap→region lookup (§5).
class RegionMaskEncoder {
  RegionMaskEncoder._();

  /// Create a new PNG where each detected region is flat-filled with
  /// its encoded ID color.
  ///
  /// Returns the encoded PNG bytes.
  static Uint8List encode(
    List<DetectedRegion> regions,
    int width,
    int height,
  ) {
    final image = ImageUtils.createImage(width, height);

    // Fill background with black (region ID 0)
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        ImageUtils.setPixel(image, x, y, 0, 0, 0, 255);
      }
    }

    // Paint each region with its encoded ID color
    for (final region in regions) {
      final color = ColorUtils.encodeRegionId(region.assignedId);
      final r = (color.r * 255.0).round().clamp(0, 255);
      final g = (color.g * 255.0).round().clamp(0, 255);
      final b = (color.b * 255.0).round().clamp(0, 255);

      for (final pixel in region.pixels) {
        ImageUtils.setPixel(image, pixel.x, pixel.y, r, g, b, 255);
      }
    }

    return ImageUtils.encodePng(image);
  }

  /// Verify that an encoded mask correctly maps back to the expected region IDs.
  ///
  /// Returns a list of error messages. Empty list = all checks passed.
  static List<String> verify(
    Uint8List maskBytes,
    List<DetectedRegion> regions,
  ) {
    final errors = <String>[];
    final image = ImageUtils.decodePng(maskBytes);

    for (final region in regions) {
      // Sample a few pixels from each region to verify encoding
      final samplesToCheck = region.pixels.length > 10
          ? [
              region.pixels.first,
              region.pixels[region.pixels.length ~/ 2],
              region.pixels.last,
            ]
          : region.pixels;

      for (final pixel in samplesToCheck) {
        final px = ImageUtils.getPixel(image, pixel.x, pixel.y);
        final decodedId =
            ColorUtils.decodeRegionId(px.r, px.g, px.b, px.a);
        if (decodedId != region.assignedId) {
          errors.add(
            'Region ${region.assignedId}: pixel (${pixel.x}, ${pixel.y}) '
            'decoded as ID $decodedId instead of ${region.assignedId}',
          );
        }
      }
    }

    return errors;
  }
}
