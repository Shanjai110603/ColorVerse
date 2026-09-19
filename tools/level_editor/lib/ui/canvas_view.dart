import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;

import '../editor/editor_state.dart';
import '../utils/color_utils.dart';
import '../utils/image_utils.dart';

/// Zoomable, pannable canvas view that displays the line art image
/// with region overlay. Clicking a region selects it.
class CanvasView extends ConsumerStatefulWidget {
  const CanvasView({super.key});

  @override
  ConsumerState<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends ConsumerState<CanvasView> {
  final TransformationController _transformController =
      TransformationController();

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editorProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InteractiveViewer(
        transformationController: _transformController,
        minScale: 0.1,
        maxScale: 10.0,
        boundaryMargin: const EdgeInsets.all(500),
        child: GestureDetector(
          onTapDown: (details) => _handleTap(details, state),
          child: CustomPaint(
            painter: _CanvasPainter(
              lineArt: state.lineArtImage,
              overlay: state.overlayImage,
              detectedRegions: state.detectedRegions,
              selectedRegionId: state.selectedRegionId,
              regionDefinitions: state.regionDefinitions,
            ),
            size: _computeCanvasSize(state),
          ),
        ),
      ),
    );
  }

  Size _computeCanvasSize(EditorState state) {
    final image = state.lineArtImage ?? state.overlayImage;
    if (image == null) return const Size(800, 600);
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  void _handleTap(TapDownDetails details, EditorState state) {
    if (state.overlayImage == null || state.detectedRegions.isEmpty) return;

    // Convert tap position to image coordinates
    final matrix = _transformController.value.clone();
    matrix.invert();
    final localPos = MatrixUtils.transformPoint(
      matrix,
      details.localPosition,
    );

    final x = localPos.dx.toInt();
    final y = localPos.dy.toInt();
    final image = state.overlayImage!;

    if (x < 0 || x >= image.width || y < 0 || y >= image.height) return;

    // Find which region was clicked by checking pixel color
    final px = ImageUtils.getPixel(image, x, y);

    // Skip background/border pixels
    if (px.a < 128 || (px.r < 10 && px.g < 10 && px.b < 10)) {
      ref.read(editorProvider.notifier).selectRegion(null);
      return;
    }

    // Find the region that contains this pixel color
    final colorKey = ColorUtils.pixelKey(px.r, px.g, px.b, px.a);
    for (final region in state.detectedRegions) {
      if (region.originalColorKey == colorKey) {
        ref.read(editorProvider.notifier).selectRegion(region.assignedId);
        return;
      }
    }

    ref.read(editorProvider.notifier).selectRegion(null);
  }
}

/// Custom painter that renders the line art with colored region overlay.
class _CanvasPainter extends CustomPainter {
  final img.Image? lineArt;
  final img.Image? overlay;
  final List detectedRegions;
  final int? selectedRegionId;
  final Map regionDefinitions;

  _CanvasPainter({
    this.lineArt,
    this.overlay,
    required this.detectedRegions,
    this.selectedRegionId,
    required this.regionDefinitions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a checkered background to indicate transparency
    _drawCheckerboard(canvas, size);

    // Draw line art as base layer
    if (lineArt != null) {
      _drawImage(canvas, lineArt!);
    }

    // Draw overlay with semi-transparent region colors
    if (overlay != null && detectedRegions.isNotEmpty) {
      _drawRegionOverlay(canvas, size);
    }
  }

  void _drawCheckerboard(Canvas canvas, Size size) {
    const tileSize = 16.0;
    final paint1 = Paint()..color = const Color(0xFF2A2A3A);
    final paint2 = Paint()..color = const Color(0xFF252535);

    for (var y = 0.0; y < size.height; y += tileSize) {
      for (var x = 0.0; x < size.width; x += tileSize) {
        final isEven =
            ((x ~/ tileSize) + (y ~/ tileSize)) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, tileSize, tileSize),
          isEven ? paint1 : paint2,
        );
      }
    }
  }

  void _drawImage(Canvas canvas, img.Image image) {
    // Convert img.Image to a format we can draw
    // For the desktop editor, we'll draw pixel-by-pixel using
    // the image data. In production, we'd cache a ui.Image.
    final paint = Paint();
    for (var y = 0; y < image.height; y++) {
      for (var x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);
        final a = pixel.a.toInt();
        if (a < 10) continue;
        paint.color = Color.fromARGB(
          a,
          pixel.r.toInt(),
          pixel.g.toInt(),
          pixel.b.toInt(),
        );
        canvas.drawRect(
          Rect.fromLTWH(x.toDouble(), y.toDouble(), 1, 1),
          paint,
        );
      }
    }
  }

  void _drawRegionOverlay(Canvas canvas, Size size) {
    if (overlay == null) return;
    final paint = Paint();

    for (final region in detectedRegions) {
      final dr = region as dynamic;
      final isSelected = dr.assignedId == selectedRegionId;
      final alpha = isSelected ? 180 : 80;

      // Use the target color if defined, otherwise a default
      Color fillColor;
      final regDef = regionDefinitions[dr.assignedId];
      if (regDef != null) {
        fillColor = ColorUtils.hexToColor(regDef.targetColor)
            .withAlpha(alpha);
      } else {
        fillColor = Color.fromARGB(alpha, 100, 200, 255);
      }
      paint.color = fillColor;

      for (final pixel in dr.pixels) {
        canvas.drawRect(
          Rect.fromLTWH(
            (pixel as dynamic).x.toDouble(),
            (pixel as dynamic).y.toDouble(),
            1,
            1,
          ),
          paint,
        );
      }

      // Draw selection highlight border for selected region
      if (isSelected) {
        final borderPaint = Paint()
          ..color = const Color(0xFFF9E2AF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawRect(dr.boundingBox as Rect, borderPaint);

        // Draw region ID label
        final textPainter = TextPainter(
          text: TextSpan(
            text: '#${dr.assignedId}',
            style: const TextStyle(
              color: Color(0xFFF9E2AF),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        final centroid = dr.centroid as Offset;
        textPainter.paint(
          canvas,
          centroid - Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CanvasPainter oldDelegate) {
    return lineArt != oldDelegate.lineArt ||
        overlay != oldDelegate.overlay ||
        selectedRegionId != oldDelegate.selectedRegionId ||
        detectedRegions != oldDelegate.detectedRegions;
  }
}
