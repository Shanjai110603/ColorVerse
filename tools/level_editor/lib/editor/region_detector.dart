import 'dart:collection';
import 'dart:math';
import 'dart:ui' show Offset, Rect;

import 'package:image/image.dart' as img;

import '../utils/color_utils.dart';
import '../utils/image_utils.dart';

/// A detected contiguous region of uniform color in the overlay image.
class DetectedRegion {
  /// Stable integer ID assigned to this region (1-based).
  final int assignedId;

  /// The original color the artist used to paint this region.
  final int originalColorKey;

  /// All pixel coordinates belonging to this region.
  final List<Point<int>> pixels;

  /// Geometric center of the region.
  final Offset centroid;

  /// Axis-aligned bounding box.
  final Rect boundingBox;

  const DetectedRegion({
    required this.assignedId,
    required this.originalColorKey,
    required this.pixels,
    required this.centroid,
    required this.boundingBox,
  });
}

/// Parses an artist-supplied region overlay image and detects contiguous
/// flat-color blobs, assigning each a stable integer region ID.
///
/// Algorithm:
/// 1. Scan all pixels, group by exact RGBA color (ignoring transparent/black pixels)
/// 2. For each unique color group, flood-fill to find connected components
/// 3. Assign each component a monotonically increasing integer ID (1-based)
/// 4. Compute centroid and bounding box for each region
class RegionDetector {
  RegionDetector._();

  /// Detect all contiguous regions in the given overlay image.
  ///
  /// [overlayImage] is the decoded overlay PNG where each region is
  /// flat-filled with a unique color by the artist.
  ///
  /// Returns a list of [DetectedRegion]s sorted by assigned ID.
  /// Transparent and black pixels are treated as background/borders.
  static List<DetectedRegion> detect(img.Image overlayImage) {
    final width = overlayImage.width;
    final height = overlayImage.height;

    // Track which pixels have been visited
    final visited = List.filled(width * height, false);

    final regions = <DetectedRegion>[];
    var nextId = 1;

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final idx = y * width + x;
        if (visited[idx]) continue;

        final px = ImageUtils.getPixel(overlayImage, x, y);

        // Skip transparent pixels (background)
        if (px.a < 128) {
          visited[idx] = true;
          continue;
        }

        // Skip black pixels (borders/lines)
        if (px.r < 10 && px.g < 10 && px.b < 10) {
          visited[idx] = true;
          continue;
        }

        // Found an unvisited, non-background pixel — flood fill from here
        final colorKey = ColorUtils.pixelKey(px.r, px.g, px.b, px.a);
        final regionPixels = _floodFill(
          overlayImage,
          visited,
          x,
          y,
          px.r,
          px.g,
          px.b,
          width,
          height,
        );

        if (regionPixels.isEmpty) continue;

        // Compute centroid and bounding box
        var sumX = 0.0;
        var sumY = 0.0;
        var minX = width;
        var minY = height;
        var maxX = 0;
        var maxY = 0;

        for (final p in regionPixels) {
          sumX += p.x;
          sumY += p.y;
          if (p.x < minX) minX = p.x;
          if (p.y < minY) minY = p.y;
          if (p.x > maxX) maxX = p.x;
          if (p.y > maxY) maxY = p.y;
        }

        final centroid = Offset(
          sumX / regionPixels.length,
          sumY / regionPixels.length,
        );
        final boundingBox = Rect.fromLTRB(
          minX.toDouble(),
          minY.toDouble(),
          maxX.toDouble() + 1,
          maxY.toDouble() + 1,
        );

        regions.add(DetectedRegion(
          assignedId: nextId++,
          originalColorKey: colorKey,
          pixels: regionPixels,
          centroid: centroid,
          boundingBox: boundingBox,
        ));
      }
    }

    return regions;
  }

  /// BFS flood-fill from (startX, startY) collecting all connected pixels
  /// with the same color (within tolerance).
  static List<Point<int>> _floodFill(
    img.Image image,
    List<bool> visited,
    int startX,
    int startY,
    int targetR,
    int targetG,
    int targetB,
    int width,
    int height,
  ) {
    final pixels = <Point<int>>[];
    final queue = Queue<Point<int>>();
    queue.add(Point(startX, startY));
    visited[startY * width + startX] = true;

    // Color matching tolerance (to handle anti-aliasing / compression artifacts)
    const tolerance = 15;

    while (queue.isNotEmpty) {
      final p = queue.removeFirst();
      pixels.add(p);

      // Check 4-connected neighbors
      for (final (dx, dy) in [(0, -1), (0, 1), (-1, 0), (1, 0)]) {
        final nx = p.x + dx;
        final ny = p.y + dy;

        if (nx < 0 || nx >= width || ny < 0 || ny >= height) continue;

        final nIdx = ny * width + nx;
        if (visited[nIdx]) continue;

        final px = ImageUtils.getPixel(image, nx, ny);

        // Skip transparent
        if (px.a < 128) {
          visited[nIdx] = true;
          continue;
        }

        // Check if color matches within tolerance
        if ((px.r - targetR).abs() <= tolerance &&
            (px.g - targetG).abs() <= tolerance &&
            (px.b - targetB).abs() <= tolerance) {
          visited[nIdx] = true;
          queue.add(Point(nx, ny));
        }
      }
    }

    return pixels;
  }
}
