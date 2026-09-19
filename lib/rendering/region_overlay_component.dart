import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components.dart';

import 'fill_state.dart';
import 'region_mask_buffer.dart';

/// Flame component that renders filled regions as a colored overlay.
///
/// Sits between the line art (below) and animation effects (above).
/// Maintains a cached `dart:ui.Image` that is updated only when new
/// regions are filled — NOT every frame. This keeps the per-frame cost
/// to a single image blit regardless of how many regions are filled.
class RegionOverlayComponent extends Component with HasGameReference {
  /// The mask buffer for pixel-level region data.
  final RegionMaskBuffer maskBuffer;

  /// Current fill state.
  final FillState fillState;

  final int _width;
  final int _height;

  /// Cached overlay image — rebuilt only when fills change.
  ui.Image? _overlayImage;

  /// Whether the overlay needs to be redrawn.
  bool _dirty = true;

  /// Raw RGBA pixel buffer for building the overlay.
  late Uint8List _pixelBuffer;

  RegionOverlayComponent({
    required this.maskBuffer,
    required this.fillState,
  })  : _width = maskBuffer.width,
        _height = maskBuffer.height;

  @override
  Future<void> onLoad() async {
    _pixelBuffer = Uint8List(_width * _height * 4);
    await _rebuildOverlay();
  }

  /// Called when a region is filled — paints it and marks overlay dirty.
  void onRegionFilled(int regionId, ui.Color color) {
    _paintRegion(regionId, color);
    _dirty = true;
  }

  void _paintRegion(int regionId, ui.Color color) {
    final r = (color.r * 255).round().clamp(0, 255);
    final g = (color.g * 255).round().clamp(0, 255);
    final b = (color.b * 255).round().clamp(0, 255);
    const a = 220; // semi-transparent so line art shows through

    for (var y = 0; y < _height; y++) {
      for (var x = 0; x < _width; x++) {
        if (maskBuffer.getRegionId(x, y) == regionId) {
          final offset = (y * _width + x) * 4;
          _pixelBuffer[offset] = r;
          _pixelBuffer[offset + 1] = g;
          _pixelBuffer[offset + 2] = b;
          _pixelBuffer[offset + 3] = a;
        }
      }
    }
  }

  /// Rebuild overlay for all currently filled regions (used on load/restore).
  Future<void> _rebuildOverlay() async {
    _pixelBuffer.fillRange(0, _pixelBuffer.length, 0);
    for (final regionId in fillState.filledRegionIds) {
      final color = fillState.getColor(regionId);
      if (color != null) _paintRegion(regionId, color);
    }
    await _updateImage();
  }

  Future<void> _updateImage() async {
    final buffer =
        await ui.ImmutableBuffer.fromUint8List(_pixelBuffer);
    final descriptor = ui.ImageDescriptor.raw(
      buffer,
      width: _width,
      height: _height,
      pixelFormat: ui.PixelFormat.rgba8888,
    );
    final codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();
    _overlayImage = frame.image;
    _dirty = false;
  }

  @override
  void render(ui.Canvas canvas) {
    if (_overlayImage != null) {
      canvas.drawImage(_overlayImage!, ui.Offset.zero, ui.Paint());
    }
  }

  @override
  void update(double dt) {
    if (_dirty) {
      _updateImage();
    }
  }
}
