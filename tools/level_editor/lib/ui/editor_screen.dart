import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/editor_state.dart';
import '../editor/level_exporter.dart';
import '../editor/level_importer.dart';
import 'canvas_view.dart';
import 'export_dialog.dart';
import 'hidden_event_editor.dart';
import 'level_metadata_panel.dart';
import 'region_panel.dart';

/// Main editor screen with split-pane layout:
/// - Left: zoomable canvas showing line art + region overlay
/// - Right: properties panel (metadata, selected region, hidden events)
class EditorScreen extends ConsumerWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editorProvider);
    final notifier = ref.read(editorProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      body: Column(
        children: [
          // Menu bar
          _buildMenuBar(context, ref, state, notifier),
          // Main content
          Expanded(
            child: Row(
              children: [
                // Canvas (left, 70%)
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF181825),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF313244),
                        width: 1,
                      ),
                    ),
                    child: state.lineArtImage != null ||
                            state.overlayImage != null
                        ? const CanvasView()
                        : _buildEmptyCanvas(context, notifier),
                  ),
                ),
                // Properties panel (right, 30%)
                SizedBox(
                  width: 360,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 4, 4, 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E2E),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF313244),
                        width: 1,
                      ),
                    ),
                    child: _buildPropertiesPanel(state),
                  ),
                ),
              ],
            ),
          ),
          // Status bar
          _buildStatusBar(state),
        ],
      ),
    );
  }

  Widget _buildMenuBar(
    BuildContext context,
    WidgetRef ref,
    EditorState state,
    EditorNotifier notifier,
  ) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xFF181825),
        border: Border(
          bottom: BorderSide(color: Color(0xFF313244)),
        ),
      ),
      child: Row(
        children: [
          // App title
          const Text(
            '🎨 ColorVerse Level Editor',
            style: TextStyle(
              color: Color(0xFFCDD6F4),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 24),
          // Import line art
          _menuButton(
            icon: Icons.image_outlined,
            label: 'Import Line Art',
            onPressed: () => _importLineArt(notifier),
          ),
          const SizedBox(width: 8),
          // Import overlay
          _menuButton(
            icon: Icons.layers_outlined,
            label: 'Import Overlay',
            onPressed: () => _importOverlay(notifier),
          ),
          const SizedBox(width: 8),
          // Import existing level.json
          _menuButton(
            icon: Icons.folder_open_outlined,
            label: 'Open Level',
            onPressed: () => _importLevel(notifier),
          ),
          const Spacer(),
          // Export
          _menuButton(
            icon: Icons.save_outlined,
            label: 'Export',
            onPressed: state.levelDefinition != null &&
                    state.detectedRegions.isNotEmpty
                ? () => _exportLevel(context, ref)
                : null,
            primary: true,
          ),
        ],
      ),
    );
  }

  Widget _menuButton({
    required IconData icon,
    required String label,
    VoidCallback? onPressed,
    bool primary = false,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: TextButton.styleFrom(
        foregroundColor:
            primary ? const Color(0xFF89B4FA) : const Color(0xFFBAC2DE),
        disabledForegroundColor: const Color(0xFF585B70),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  Widget _buildEmptyCanvas(BuildContext context, EditorNotifier notifier) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'Import a line art image and region overlay to begin',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => _importLineArt(notifier),
                icon: const Icon(Icons.image_outlined),
                label: const Text('Line Art'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF313244),
                  foregroundColor: const Color(0xFFCDD6F4),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _importOverlay(notifier),
                icon: const Icon(Icons.layers_outlined),
                label: const Text('Region Overlay'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF313244),
                  foregroundColor: const Color(0xFFCDD6F4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesPanel(EditorState state) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        // Level metadata
        const LevelMetadataPanel(),
        const SizedBox(height: 16),
        // Selected region properties
        if (state.selectedRegionId != null) ...[
          const RegionPanel(),
          const SizedBox(height: 16),
        ],
        // Hidden events
        const HiddenEventEditor(),
      ],
    );
  }

  Widget _buildStatusBar(EditorState state) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF181825),
        border: Border(
          top: BorderSide(color: Color(0xFF313244)),
        ),
      ),
      child: Row(
        children: [
          Text(
            state.statusMessage,
            style: const TextStyle(
              color: Color(0xFF6C7086),
              fontSize: 12,
            ),
          ),
          const Spacer(),
          if (state.detectedRegions.isNotEmpty)
            Text(
              '${state.detectedRegions.length} regions',
              style: const TextStyle(
                color: Color(0xFF6C7086),
                fontSize: 12,
              ),
            ),
          if (state.isDirty) ...[
            const SizedBox(width: 12),
            const Text(
              '● Unsaved',
              style: TextStyle(
                color: Color(0xFFF38BA8),
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _importLineArt(EditorNotifier notifier) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg'],
      dialogTitle: 'Select Line Art Image',
    );
    if (result != null && result.files.single.path != null) {
      final bytes = File(result.files.single.path!).readAsBytesSync();
      notifier.loadLineArt(bytes);
    }
  }

  Future<void> _importOverlay(EditorNotifier notifier) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
      dialogTitle: 'Select Region Overlay Image',
    );
    if (result != null && result.files.single.path != null) {
      final bytes = File(result.files.single.path!).readAsBytesSync();
      notifier.loadOverlay(bytes);
    }
  }

  Future<void> _importLevel(EditorNotifier notifier) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      dialogTitle: 'Open Existing Level',
    );
    if (result != null && result.files.single.path != null) {
      final level =
          await LevelImporter.importLevelJson(result.files.single.path!);
      notifier.loadLevelDefinition(level);
    }
  }

  Future<void> _exportLevel(BuildContext context, WidgetRef ref) async {
    final state = ref.read(editorProvider);
    final notifier = ref.read(editorProvider.notifier);

    if (state.levelDefinition == null || state.detectedRegions.isEmpty) return;

    // Pick output directory
    final outputDir = await FilePicker.platform.getDirectoryPath(
      dialogTitle: 'Select Export Directory',
    );
    if (outputDir == null) return;

    final result = await LevelExporter.export(
      level: state.levelDefinition!,
      regions: state.detectedRegions,
      lineArtBytes: state.lineArtBytes!,
      maskWidth: state.overlayImage!.width,
      maskHeight: state.overlayImage!.height,
      outputDir: outputDir,
    );

    if (result.success) notifier.markSaved();

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (_) => ExportDialog(result: result),
      );
    }
  }
}
