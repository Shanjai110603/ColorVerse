import 'package:colorverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/editor_state.dart';
import 'trigger_editor.dart';

/// Properties panel for the currently selected region.
/// Shows region ID, target color picker, palette slot, and trigger list.
class RegionPanel extends ConsumerWidget {
  const RegionPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editorProvider);
    final regionId = state.selectedRegionId;
    if (regionId == null) return const SizedBox.shrink();

    final regionDef = state.regionDefinitions[regionId];
    if (regionDef == null) return const SizedBox.shrink();

    final notifier = ref.read(editorProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF89B4FA).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Region #$regionId',
                style: const TextStyle(
                  color: Color(0xFF89B4FA),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, size: 16),
              color: const Color(0xFF6C7086),
              onPressed: () => notifier.selectRegion(null),
              tooltip: 'Deselect',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Target color
        Row(
          children: [
            const Text(
              'Target Color',
              style: TextStyle(color: Color(0xFF6C7086), fontSize: 12),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => _pickColor(context, regionId, regionDef, notifier),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _parseColor(regionDef.targetColor),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF585B70)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextField(
                controller: TextEditingController(text: regionDef.targetColor),
                onSubmitted: (v) => notifier.updateRegionColor(regionId, v),
                style: const TextStyle(
                  color: Color(0xFFCDD6F4),
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  filled: true,
                  fillColor: const Color(0xFF313244),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Palette slot
        Row(
          children: [
            const Text(
              'Palette Slot',
              style: TextStyle(color: Color(0xFF6C7086), fontSize: 12),
            ),
            const Spacer(),
            SizedBox(
              width: 60,
              child: TextField(
                controller: TextEditingController(
                    text: '${regionDef.paletteSlot}'),
                keyboardType: TextInputType.number,
                onSubmitted: (v) => notifier.updateRegionPaletteSlot(
                    regionId, int.tryParse(v) ?? 1),
                style: const TextStyle(
                    color: Color(0xFFCDD6F4), fontSize: 12),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  filled: true,
                  fillColor: const Color(0xFF313244),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Triggers
        TriggerEditor(regionId: regionId, triggers: regionDef.onFillTriggers),
      ],
    );
  }

  Color _parseColor(String hex) {
    try {
      final h = hex.replaceFirst('#', '');
      return Color(int.parse('FF$h', radix: 16));
    } catch (_) {
      return Colors.white;
    }
  }

  void _pickColor(
    BuildContext context,
    int regionId,
    RegionDefinition regionDef,
    EditorNotifier notifier,
  ) {
    // Simple color picker using a grid of preset colors
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E),
          title: const Text(
            'Pick Target Color',
            style: TextStyle(color: Color(0xFFCDD6F4), fontSize: 16),
          ),
          content: SizedBox(
            width: 280,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                '#2E7D32', '#4CAF50', '#81C784', '#3B7A45',
                '#1565C0', '#42A5F5', '#90CAF9', '#5CA86C',
                '#6A1B9A', '#AB47BC', '#CE93D8', '#2D5A1E',
                '#C62828', '#EF5350', '#EF9A9A', '#8B4513',
                '#E65100', '#FF9800', '#FFCC80', '#FDD835',
                '#37474F', '#78909C', '#B0BEC5', '#FFFFFF',
              ].map((hex) {
                final color = _parseColor(hex);
                return GestureDetector(
                  onTap: () {
                    notifier.updateRegionColor(regionId, hex);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: regionDef.targetColor == hex
                            ? const Color(0xFFF9E2AF)
                            : const Color(0xFF585B70),
                        width: regionDef.targetColor == hex ? 2 : 1,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
