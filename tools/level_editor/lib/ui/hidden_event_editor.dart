import 'package:colorverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/editor_state.dart';

/// Editor for hidden events in the level.
/// Supports adding and removing events with condition/reveal configurations.
class HiddenEventEditor extends ConsumerWidget {
  const HiddenEventEditor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editorProvider);
    final notifier = ref.read(editorProvider.notifier);
    final events = state.levelDefinition?.hiddenEvents ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Hidden Events',
              style: TextStyle(
                color: Color(0xFFA6ADC8),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${events.length})',
              style: const TextStyle(color: Color(0xFF585B70), fontSize: 11),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.add, size: 16, color: Color(0xFFA6E3A1)),
              tooltip: 'Add Hidden Event',
              onPressed: () => _addEvent(context, notifier),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ],
        ),
        if (events.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              'No hidden events defined.',
              style: TextStyle(color: Color(0xFF585B70), fontSize: 11),
            ),
          ),
        ...events.asMap().entries.map((entry) {
          final idx = entry.key;
          final event = entry.value;
          return _EventTile(
            event: event,
            onDelete: () => notifier.removeHiddenEvent(idx),
          );
        }),
      ],
    );
  }

  void _addEvent(BuildContext context, EditorNotifier notifier) {
    final idController = TextEditingController(text: 'event_1');
    final regionIdsController = TextEditingController(text: '1,2,3');
    final assetController = TextEditingController(text: 'hidden_sprite.riv');
    final posXController = TextEditingController(text: '0.5');
    final posYController = TextEditingController(text: '0.5');
    String conditionType = 'allRegionsFilled';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E1E2E),
              title: const Text(
                'Add Hidden Event',
                style: TextStyle(color: Color(0xFFCDD6F4), fontSize: 16),
              ),
              content: SizedBox(
                width: 320,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _dialogField('Event ID', idController),
                      const SizedBox(height: 12),
                      const Text('Condition',
                          style: TextStyle(
                              color: Color(0xFF6C7086), fontSize: 12)),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        initialValue: conditionType,
                        onChanged: (v) =>
                            setDialogState(() => conditionType = v!),
                        items: const [
                          DropdownMenuItem(
                            value: 'allRegionsFilled',
                            child: Text('All Regions Filled'),
                          ),
                          DropdownMenuItem(
                            value: 'anyRegionFilled',
                            child: Text('Any Region Filled'),
                          ),
                          DropdownMenuItem(
                            value: 'regionFilledWithinTime',
                            child: Text('Regions Filled Within Time'),
                          ),
                        ],
                        style: const TextStyle(
                            color: Color(0xFFCDD6F4), fontSize: 13),
                        dropdownColor: const Color(0xFF313244),
                        decoration: InputDecoration(
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
                      const SizedBox(height: 8),
                      _dialogField(
                          'Region IDs (comma-separated)', regionIdsController),
                      const SizedBox(height: 12),
                      const Text('Reveal',
                          style: TextStyle(
                              color: Color(0xFF6C7086), fontSize: 12)),
                      const SizedBox(height: 4),
                      _dialogField('Asset', assetController),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                              child: _dialogField('Pos X', posXController)),
                          const SizedBox(width: 8),
                          Expanded(
                              child: _dialogField('Pos Y', posYController)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel',
                      style: TextStyle(color: Color(0xFF6C7086))),
                ),
                ElevatedButton(
                  onPressed: () {
                    final regionIds = regionIdsController.text
                        .split(',')
                        .map((s) => int.tryParse(s.trim()))
                        .where((id) => id != null)
                        .cast<int>()
                        .toList();

                    final condition = switch (conditionType) {
                      'allRegionsFilled' =>
                        EventCondition.allRegionsFilled(regionIds: regionIds),
                      'anyRegionFilled' =>
                        EventCondition.anyRegionFilled(regionIds: regionIds),
                      'regionFilledWithinTime' =>
                        EventCondition.regionFilledWithinTime(
                          regionIds: regionIds,
                          timeLimitMs: 5000,
                        ),
                      _ =>
                        EventCondition.allRegionsFilled(regionIds: regionIds),
                    };

                    notifier.addHiddenEvent(
                      HiddenEventDefinition(
                        id: idController.text,
                        condition: condition,
                        reveal: EventReveal.spriteReveal(
                          asset: assetController.text,
                          position: [
                            double.tryParse(posXController.text) ?? 0.5,
                            double.tryParse(posYController.text) ?? 0.5,
                          ],
                        ),
                      ),
                    );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA6E3A1),
                    foregroundColor: const Color(0xFF1E1E2E),
                  ),
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _dialogField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF6C7086), fontSize: 12),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        filled: true,
        fillColor: const Color(0xFF313244),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// Individual hidden event tile showing condition and reveal info.
class _EventTile extends StatelessWidget {
  final HiddenEventDefinition event;
  final VoidCallback onDelete;

  const _EventTile({required this.event, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final conditionText = switch (event.condition) {
      AllRegionsFilledCondition(:final regionIds) =>
        'All filled: ${regionIds.join(", ")}',
      AnyRegionFilledCondition(:final regionIds) =>
        'Any filled: ${regionIds.join(", ")}',
      RegionFilledWithinTimeCondition(:final regionIds, :final timeLimitMs) =>
        'Within ${timeLimitMs}ms: ${regionIds.join(", ")}',
    };

    final revealText = switch (event.reveal) {
      SpriteReveal(:final asset, :final position) =>
        'Sprite: $asset @ (${position[0]}, ${position[1]})',
    };

    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.visibility_outlined,
              size: 14, color: Color(0xFFA6E3A1)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.id,
                  style: const TextStyle(
                    color: Color(0xFFCDD6F4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(conditionText,
                    style: const TextStyle(
                        color: Color(0xFF6C7086), fontSize: 10)),
                Text(revealText,
                    style: const TextStyle(
                        color: Color(0xFF6C7086), fontSize: 10)),
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
