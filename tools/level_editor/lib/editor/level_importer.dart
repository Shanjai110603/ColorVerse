import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:colorverse/models/models.dart';

/// Imports an existing level.json (and optionally its images) for re-editing.
class LevelImporter {
  LevelImporter._();

  /// Import a level.json file and parse it into a [LevelDefinition].
  static Future<LevelDefinition> importLevelJson(String jsonPath) async {
    final file = File(jsonPath);
    if (!file.existsSync()) {
      throw FileSystemException('level.json not found', jsonPath);
    }
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return LevelDefinition.fromJson(json);
  }

  /// Load image bytes from a file path.
  static Future<Uint8List> loadImage(String imagePath) async {
    final file = File(imagePath);
    if (!file.existsSync()) {
      throw FileSystemException('Image file not found', imagePath);
    }
    return file.readAsBytes();
  }
}
