import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flame/components.dart';

/// Flame component that renders the line art PNG as the base visual layer.
///
/// This sits at the bottom of the rendering stack — region fills and
/// animations are drawn on top. The line art image defines the visual
/// size of the level canvas.
class LineArtComponent extends SpriteComponent {
  LineArtComponent._({required super.sprite, required super.size});

  /// Create a LineArtComponent from raw PNG bytes.
  ///
  /// Decodes the image using Flutter's `dart:ui` for hardware-accelerated
  /// rendering (unlike the `image` package used for mask decoding, which
  /// is pure-Dart and doesn't produce a GPU-backed texture).
  static Future<LineArtComponent> fromBytes(Uint8List pngBytes) async {
    final codec = await ui.instantiateImageCodec(pngBytes);
    final frame = await codec.getNextFrame();
    final uiImage = frame.image;

    final sprite = Sprite(uiImage);
    return LineArtComponent._(
      sprite: sprite,
      size: Vector2(
        uiImage.width.toDouble(),
        uiImage.height.toDouble(),
      ),
    );
  }
}
