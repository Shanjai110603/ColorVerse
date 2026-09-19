import 'package:colorverse/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../editor/editor_state.dart';

/// Level metadata editing panel (ID, name, world, difficulty, rewards).
class LevelMetadataPanel extends ConsumerStatefulWidget {
  const LevelMetadataPanel({super.key});

  @override
  ConsumerState<LevelMetadataPanel> createState() =>
      _LevelMetadataPanelState();
}

class _LevelMetadataPanelState extends ConsumerState<LevelMetadataPanel> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _coinsController;
  late TextEditingController _gemsController;
  late TextEditingController _xpController;
  String _world = 'forest';
  String _difficulty = 'easy';

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _coinsController = TextEditingController(text: '0');
    _gemsController = TextEditingController(text: '0');
    _xpController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _coinsController.dispose();
    _gemsController.dispose();
    _xpController.dispose();
    super.dispose();
  }

  void _syncFromState(EditorState state) {
    final level = state.levelDefinition;
    if (level == null) return;
    if (_idController.text != level.levelId) {
      _idController.text = level.levelId;
    }
    if (_nameController.text != level.displayName) {
      _nameController.text = level.displayName;
    }
    _world = level.world;
    _difficulty = level.difficulty;
    _coinsController.text = '${level.completionRewards.coins}';
    _gemsController.text = '${level.completionRewards.gems}';
    _xpController.text = '${level.completionRewards.xp}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editorProvider);
    if (state.levelDefinition == null) {
      return const _SectionHeader(title: 'Level Metadata', subtitle: 'No level loaded');
    }

    // Sync controllers on first build or when level changes
    _syncFromState(state);

    final notifier = ref.read(editorProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Level Metadata'),
        const SizedBox(height: 8),
        _field('Level ID', _idController, (v) {
          notifier.updateMetadata(levelId: v);
        }),
        const SizedBox(height: 8),
        _field('Display Name', _nameController, (v) {
          notifier.updateMetadata(displayName: v);
        }),
        const SizedBox(height: 8),
        _dropdown('World', _world, ['forest', 'ocean', 'mountain', 'sky', 'cave'], (v) {
          setState(() => _world = v!);
          notifier.updateMetadata(world: v!);
        }),
        const SizedBox(height: 8),
        _dropdown('Difficulty', _difficulty, ['easy', 'medium', 'hard', 'boss'], (v) {
          setState(() => _difficulty = v!);
          notifier.updateMetadata(difficulty: v!);
        }),
        const SizedBox(height: 12),
        const Text(
          'Completion Rewards',
          style: TextStyle(color: Color(0xFF6C7086), fontSize: 11),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: _numberField('🪙', _coinsController, (v) {
              notifier.updateMetadata(
                completionRewards: RewardBundle(
                  coins: v,
                  gems: int.tryParse(_gemsController.text) ?? 0,
                  xp: int.tryParse(_xpController.text) ?? 0,
                ),
              );
            })),
            const SizedBox(width: 8),
            Expanded(child: _numberField('💎', _gemsController, (v) {
              notifier.updateMetadata(
                completionRewards: RewardBundle(
                  coins: int.tryParse(_coinsController.text) ?? 0,
                  gems: v,
                  xp: int.tryParse(_xpController.text) ?? 0,
                ),
              );
            })),
            const SizedBox(width: 8),
            Expanded(child: _numberField('⭐', _xpController, (v) {
              notifier.updateMetadata(
                completionRewards: RewardBundle(
                  coins: int.tryParse(_coinsController.text) ?? 0,
                  gems: int.tryParse(_gemsController.text) ?? 0,
                  xp: v,
                ),
              );
            })),
          ],
        ),
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController controller,
    ValueChanged<String> onChanged,
  ) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
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

  Widget _numberField(
    String emoji,
    TextEditingController controller,
    ValueChanged<int> onChanged,
  ) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: (v) => onChanged(int.tryParse(v) ?? 0),
      style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 13),
      decoration: InputDecoration(
        prefixText: '$emoji ',
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        filled: true,
        fillColor: const Color(0xFF313244),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      onChanged: onChanged,
      items: options.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
      style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 13),
      dropdownColor: const Color(0xFF313244),
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

/// Section header widget used throughout the properties panel.
class _SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionHeader({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFA6ADC8),
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: const TextStyle(color: Color(0xFF585B70), fontSize: 11),
          ),
      ],
    );
  }
}
