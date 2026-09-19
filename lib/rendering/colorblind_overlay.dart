import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../coloring/fill_controller.dart';
import 'fill_state.dart';
import 'region_mask_buffer.dart';

/// Helper mapping palette slots to distinct colorblind symbols.
class ColorblindSymbols {
  ColorblindSymbols._();

  /// Get icon data corresponding to a palette slot for UI buttons.
  static IconData getIconForSlot(int slot) {
    return switch ((slot - 1) % 6) {
      0 => Icons.circle_outlined,
      1 => Icons.add,
      2 => Icons.square_outlined,
      3 => Icons.change_history, // Triangle
      4 => Icons.star_border,
      _ => Icons.diamond_outlined,
    };
  }

  /// Draw a symbol shape on a Canvas centered at [center] with radius [size].
  static void drawSymbolOnCanvas(
    ui.Canvas canvas,
    int slot,
    ui.Offset center,
    double size,
    ui.Paint paint,
  ) {
    final symbolIndex = (slot - 1) % 6;
    switch (symbolIndex) {
      case 0: // Circle
        canvas.drawCircle(center, size * 0.7, paint);
      case 1: // Cross / Plus
        final stroke = paint.strokeWidth > 0 ? paint.strokeWidth : 2.0;
        final p = ui.Paint()
          ..color = paint.color
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = stroke;
        canvas.drawLine(
          ui.Offset(center.dx - size, center.dy),
          ui.Offset(center.dx + size, center.dy),
          p,
        );
        canvas.drawLine(
          ui.Offset(center.dx, center.dy - size),
          ui.Offset(center.dx, center.dy + size),
          p,
        );
      case 2: // Square
        final rect = ui.Rect.fromCenter(
          center: center,
          width: size * 1.4,
          height: size * 1.4,
        );
        canvas.drawRect(rect, paint);
      case 3: // Triangle
        final path = ui.Path()
          ..moveTo(center.dx, center.dy - size)
          ..lineTo(center.dx + size, center.dy + size)
          ..lineTo(center.dx - size, center.dy + size)
          ..close();
        canvas.drawPath(path, paint);
      case 4: // Star / Asterisk
        final stroke = paint.strokeWidth > 0 ? paint.strokeWidth : 2.0;
        final p = ui.Paint()
          ..color = paint.color
          ..style = ui.PaintingStyle.stroke
          ..strokeWidth = stroke;
        for (var i = 0; i < 4; i++) {
          final dx = size * 0.9 * (i % 2 == 0 ? 1 : 0.7);
          final dy = size * 0.9 * (i % 2 == 0 ? 1 : 0.7);
          canvas.drawLine(
            ui.Offset(center.dx - dx, center.dy - dy),
            ui.Offset(center.dx + dx, center.dy + dy),
            p,
          );
        }
      case 5: // Diamond
        final path = ui.Path()
          ..moveTo(center.dx, center.dy - size)
          ..lineTo(center.dx + size, center.dy)
          ..lineTo(center.dx, center.dy + size)
          ..lineTo(center.dx - size, center.dy)
          ..close();
        canvas.drawPath(path, paint);
    }
  }
}

/// Flame Component that renders pattern/symbol overlays for colorblind mode.
///
/// Draws subtle pattern symbols over filled regions so colorblind players can
/// easily identify which slot a region belongs to even without color vision.
class ColorblindOverlayComponent extends Component with HasGameReference {
  final RegionMaskBuffer maskBuffer;
  final FillState fillState;
  final FillController fillController;

  /// Cache of centroid points per region ID.
  final Map<int, ui.Offset> _centroids = {};

  bool enabled;

  ColorblindOverlayComponent({
    required this.maskBuffer,
    required this.fillState,
    required this.fillController,
    this.enabled = false,
  });

  @override
  Future<void> onLoad() async {
    _computeCentroids();
  }

  /// Pre-compute region centroids from mask buffer for overlay rendering.
  void _computeCentroids() {
    final sumsX = <int, int>{};
    final sumsY = <int, int>{};
    final counts = <int, int>{};

    for (var y = 0; y < maskBuffer.height; y += 4) {
      for (var x = 0; x < maskBuffer.width; x += 4) {
        final regionId = maskBuffer.getRegionId(x, y);
        if (regionId > 0) {
          sumsX[regionId] = (sumsX[regionId] ?? 0) + x;
          sumsY[regionId] = (sumsY[regionId] ?? 0) + y;
          counts[regionId] = (counts[regionId] ?? 0) + 1;
        }
      }
    }

    for (final regionId in counts.keys) {
      final count = counts[regionId]!;
      _centroids[regionId] = ui.Offset(
        sumsX[regionId]! / count,
        sumsY[regionId]! / count,
      );
    }
  }

  @override
  void render(ui.Canvas canvas) {
    if (!enabled) return;

    final paint = ui.Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (final regionId in fillState.filledRegionIds) {
      final region = fillController.getRegion(regionId);
      if (region == null) continue;

      final centroid = _centroids[regionId];
      if (centroid != null) {
        ColorblindSymbols.drawSymbolOnCanvas(
          canvas,
          region.paletteSlot,
          centroid,
          10.0,
          paint,
        );
      }
    }
  }
}
