import 'package:colorverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/editor_state.dart';

/// Editor for the list of triggers attached to a region.
/// Supports adding, editing, and removing Animation, SFX, and Chain triggers.
class TriggerEditor extends ConsumerWidget {
  final int regionId;
  final List<TriggerDefinition> triggers;

  const TriggerEditor({
    super.key,
    required this.regionId,
    required this.triggers,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(editorProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Triggers',
              style: TextStyle(
                color: Color(0xFFA6ADC8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${triggers.length})',
              style: const TextStyle(color: Color(0xFF585B70), fontSize: 11),
            ),
            const Spacer(),
            PopupMenuButton<String>(
              icon: const Icon(Icons.add, size: 16, color: Color(0xFF89B4FA)),
              tooltip: 'Add Trigger',
              color: const Color(0xFF313244),
              onSelected: (type) =>
                  _addTrigger(context, type, notifier),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 'animation',
                  child: Text('Animation',
                      style: TextStyle(color: Color(0xFFCDD6F4), fontSize: 13)),
                ),
                const PopupMenuItem(
                  value: 'sfx',
                  child: Text('SFX',
                      style: TextStyle(color: Color(0xFFCDD6F4), fontSize: 13)),
                ),
                const PopupMenuItem(
                  value: 'chain',
                  child: Text('Chain',
                      style: TextStyle(color: Color(0xFFCDD6F4), fontSize: 13)),
                ),
              ],
            ),
          ],
        ),
        if (triggers.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'No triggers. Click + to add.',
              style: TextStyle(color: Color(0xFF585B70), fontSize: 11),
            ),
          ),
        ...triggers.asMap().entries.map((entry) {
          final idx = entry.key;
          final trigger = entry.value;
          return _TriggerTile(
            trigger: trigger,
            onDelete: () => notifier.removeTrigger(regionId, idx),
          );
        }),
      ],
    );
  }

  void _addTrigger(
    BuildContext context,
    String type,
    EditorNotifier notifier,
  ) {
    switch (type) {
      case 'animation':
        _showAddDialog(
          context,
          title: 'Add Animation Trigger',
          fields: {'Asset': 'animation.riv', 'Anchor': 'region_centroid'},
          onSave: (values) {
            notifier.addTrigger(
              regionId,
              TriggerDefinition.animation(
                asset: values['Asset']!,
                anchor: values['Anchor']!,
              ),
            );
          },
        );
      case 'sfx':
        _showAddDialog(
          context,
          title: 'Add SFX Trigger',
          fields: {'Asset': 'sound_effect.ogg'},
          onSave: (values) {
            notifier.addTrigger(
              regionId,
              TriggerDefinition.sfx(asset: values['Asset']!),
            );
          },
        );
      case 'chain':
        _showAddDialog(
          context,
          title: 'Add Chain Trigger',
          fields: {'Target Region ID': '1', 'Delay (ms)': '800'},
          onSave: (values) {
            notifier.addTrigger(
              regionId,
              TriggerDefinition.chain(
                targetRegionId:
                    int.tryParse(values['Target Region ID']!) ?? 1,
                delayMs: int.tryParse(values['Delay (ms)']!) ?? 800,
              ),
            );
          },
        );
    }
  }

  void _showAddDialog(
    BuildContext context, {
    required String title,
    required Map<String, String> fields,
    required void Function(Map<String, String>) onSave,
  }) {
    final controllers = <String, TextEditingController>{};
    for (final entry in fields.entries) {
      controllers[entry.key] = TextEditingController(text: entry.value);
    }

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E2E),
          title: Text(
            title,
            style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  controller: entry.value,
                  style: const TextStyle(
                      color: Color(0xFFCDD6F4), fontSize: 13),
                  decoration: InputDecoration(
                    labelText: entry.key,
                    labelStyle:
                        const TextStyle(color: Color(0xFF6C7086), fontSize: 12),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    filled: true,
                    fillColor: const Color(0xFF313244),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF6C7086))),
            ),
            ElevatedButton(
              onPressed: () {
                final values = <String, String>{};
                for (final entry in controllers.entries) {
                  values[entry.key] = entry.value.text;
                }
                onSave(values);
                Navigator.pop(ctx);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF89B4FA),
                foregroundColor: const Color(0xFF1E1E2E),
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

/// Individual trigger tile with icon, description, and delete button.
class _TriggerTile extends StatelessWidget {
  final TriggerDefinition trigger;
  final VoidCallback onDelete;

  const _TriggerTile({required this.trigger, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final (icon, label, detail) = switch (trigger) {
      AnimationTrigger(:final asset, :final anchor) => (
          Icons.play_circle_outline,
          'Animation',
          '$asset @ $anchor',
        ),
      SfxTrigger(:final asset) => (
          Icons.volume_up_outlined,
          'SFX',
          asset,
        ),
      ChainTrigger(:final targetRegionId, :final delayMs) => (
          Icons.link_outlined,
          'Chain',
          '→ Region #$targetRegionId (${delayMs}ms)',
        ),
    };

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF89B4FA)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFA6ADC8),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  detail,
                  style: const TextStyle(
                    color: Color(0xFF6C7086),
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 14),
            color: const Color(0xFFF38BA8),
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
          ),
        ],
      ),
    );
  }
}
