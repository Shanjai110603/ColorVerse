import 'dart:ui' show Color;

/// Utilities for encoding/decoding region IDs to/from pixel colors.
///
/// Encoding scheme: region ID `n` → RGB(0, n >> 8, n & 0xFF).
/// This supports up to 65,535 unique region IDs (0 is reserved for "no region").
/// The red channel is reserved at 0 for future use (e.g., layer separation).
class ColorUtils {
  ColorUtils._();

  /// Encode a region ID into an ARGB color value.
  /// Region 0 = background (no region) → fully transparent black.
  static Color encodeRegionId(int regionId) {
    assert(regionId >= 0 && regionId <= 65535,
        'Region ID must be 0–65535, got $regionId');
    if (regionId == 0) return const Color(0xFF000000);
    final g = (regionId >> 8) & 0xFF;
    final b = regionId & 0xFF;
    return Color.fromARGB(255, 0, g, b);
  }

  /// Decode a region ID from RGBA pixel values.
  /// Returns 0 for background pixels (fully transparent or black).
  static int decodeRegionId(int r, int g, int b, int a) {
    // Fully transparent = no region
    if (a < 128) return 0;
    // Black = no region (border/background)
    if (r == 0 && g == 0 && b == 0) return 0;
    // Decode: ignore red channel, use green (high byte) + blue (low byte)
    return (g << 8) | b;
  }

  /// Convert a hex color string (e.g., "#3B7A45") to a Color.
  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  /// Convert a Color to a hex string (e.g., "#3B7A45").
  static String colorToHex(Color color) {
    // Use component accessors (r, g, b are 0.0–1.0 in modern Flutter)
    final r = (color.r * 255.0).round().clamp(0, 255);
    final g = (color.g * 255.0).round().clamp(0, 255);
    final b = (color.b * 255.0).round().clamp(0, 255);
    return '#${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}'
        .toUpperCase();
  }

  /// Generate a unique key for an RGBA pixel value (for grouping pixels by color).
  static int pixelKey(int r, int g, int b, int a) {
    return (a << 24) | (r << 16) | (g << 8) | b;
  }
}
