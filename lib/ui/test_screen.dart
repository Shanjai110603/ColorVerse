import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/providers.dart';
import '../models/models.dart';


/// Throwaway test screen for Phase 1 verification.
///
/// Demonstrates:
/// 1. Loading and parsing sample level.json from assets
/// 2. Displaying parsed LevelDefinition data
/// 3. Reactive PlayerProfile (coins/gems/XP) with +/- buttons
/// 4. Reactive LevelProgress with region fill buttons
/// 5. Mid-level resume: fill regions → restart → confirm persisted
///
/// This screen will be removed before production.
class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({super.key});

  @override
  ConsumerState<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  LevelDefinition? _levelDef;
  String? _parseError;

  @override
  void initState() {
    super.initState();
    _loadSampleLevel();
  }

  Future<void> _loadSampleLevel() async {
    try {
      final jsonStr = await rootBundle
          .loadString('assets/sample_levels/forest_01/level.json');
      final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
      setState(() {
        _levelDef = LevelDefinition.fromJson(jsonMap);
        _parseError = null;
      });
    } catch (e, st) {
      setState(() {
        _parseError = 'Failed to parse level.json:\n$e\n$st';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColorVerse — Phase 1 Test'),
        backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLevelSection(),
            const Divider(height: 32),
            _buildProfileSection(),
            const Divider(height: 32),
            _buildLevelProgressSection(),
            const Divider(height: 32),
            _buildResourcesSection(),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Parsed Level Definition
  // ---------------------------------------------------------------------------

  Widget _buildLevelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('📄 Level Definition',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        if (_parseError != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(_parseError!, style: const TextStyle(color: Colors.red)),
          )
        else if (_levelDef == null)
          const CircularProgressIndicator()
        else
          _buildLevelCard(_levelDef!),
      ],
    );
  }

  Widget _buildLevelCard(LevelDefinition level) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${level.displayName} (${level.levelId})',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('World: ${level.world} | Difficulty: ${level.difficulty}'),
            Text('Region count: ${level.regionCount}'),
            Text('Line art: ${level.lineArt}'),
            Text('Region mask: ${level.regionMask}'),
            Text('Weather: ${level.weatherSequence.join(" → ")}'),
            const SizedBox(height: 12),
            Text('Regions (${level.regions.length}):',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            ...level.regions.map((r) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'Region ${r.id}: ${r.targetColor} (slot ${r.paletteSlot}) '
                    '— ${r.onFillTriggers.length} trigger(s)',
                  ),
                )),
            const SizedBox(height: 12),
            Text('Hidden Events (${level.hiddenEvents.length}):',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            ...level.hiddenEvents.map((e) => Padding(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: Text('${e.id}: ${e.condition.runtimeType.toString()}'),
                )),
            const SizedBox(height: 12),
            Text('Rewards:',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Text(
                '🪙 ${level.completionRewards.coins} coins | '
                '💎 ${level.completionRewards.gems} gems | '
                '⭐ ${level.completionRewards.xp} XP | '
                '🪵 ${level.completionRewards.wood} wood | '
                '🍖 ${level.completionRewards.food} food',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Reactive Player Profile
  // ---------------------------------------------------------------------------

  Widget _buildProfileSection() {
    final profileAsync = ref.watch(playerProfileProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('👤 Player Profile (Reactive)',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        profileAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          data: (profile) => Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _currencyRow('🪙 Coins', profile.coins, () {
                    ref.read(playerProfileDaoProvider).addCoins(10);
                  }, () {
                    ref.read(playerProfileDaoProvider).addCoins(-5);
                  }),
                  _currencyRow('💎 Gems', profile.gems, () {
                    ref.read(playerProfileDaoProvider).addGems(5);
                  }, () {
                    ref.read(playerProfileDaoProvider).addGems(-2);
                  }),
                  _currencyRow('⭐ XP', profile.xp, () {
                    ref.read(playerProfileDaoProvider).addXp(25);
                  }, () {
                    ref.read(playerProfileDaoProvider).addXp(-10);
                  }),
                  const Divider(),
                  Row(
                    children: [
                      const Text('Colorblind mode: '),
                      Switch(
                        value: profile.colorblindMode,
                        onChanged: (v) {
                          ref
                              .read(playerProfileDaoProvider)
                              .updateSettings(colorblindMode: v);
                        },
                      ),
                      const Spacer(),
                      const Text('Sound: '),
                      Switch(
                        value: profile.soundOn,
                        onChanged: (v) {
                          ref
                              .read(playerProfileDaoProvider)
                              .updateSettings(soundOn: v);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currencyRow(
      String label, int value, VoidCallback onAdd, VoidCallback onSubtract) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 100, child: Text(label)),
          Text('$value', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const Spacer(),
          IconButton(
              onPressed: onSubtract,
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red)),
          IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle_outline, color: Colors.green)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3: Reactive Level Progress
  // ---------------------------------------------------------------------------

  Widget _buildLevelProgressSection() {
    final progressAsync = ref.watch(levelProgressProvider('forest_01'));
    final levelProgressDao = ref.read(levelProgressDaoProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🎨 Level Progress — forest_01 (Reactive)',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        progressAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          data: (progress) {
            final filledIds = progress != null
                ? (jsonDecode(progress.filledRegionIds) as List).cast<int>()
                : <int>[];
            final status = progress?.status ?? 'not_started';

            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: $status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: status == 'completed'
                              ? Colors.green
                              : status == 'in_progress'
                                  ? Colors.orange
                                  : Colors.grey,
                        )),
                    Text('Filled regions: ${filledIds.join(", ")}'),
                    if (progress?.starRating != null)
                      Text('Stars: ${"⭐" * progress!.starRating!}'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        // Fill region buttons for the 5 sample regions
                        for (final regionId in [14, 22, 31, 45, 67])
                          ElevatedButton(
                            onPressed: filledIds.contains(regionId)
                                ? null
                                : () => levelProgressDao.markRegionFilled(
                                    'forest_01', regionId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: filledIds.contains(regionId)
                                  ? Colors.grey
                                  : const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Fill #$regionId'),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () =>
                              levelProgressDao.markCompleted('forest_01', 3),
                          icon: const Icon(Icons.check_circle),
                          label: const Text('Complete (3★)'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton.icon(
                          onPressed: () =>
                              levelProgressDao.resetLevel('forest_01'),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Reactive Island Resources
  // ---------------------------------------------------------------------------

  Widget _buildResourcesSection() {
    final resourcesAsync = ref.watch(islandResourcesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🏝️ Island Resources (Reactive)',
            style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        resourcesAsync.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, st) => Text('Error: $e', style: const TextStyle(color: Colors.red)),
          data: (res) => Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '🪵 ${res.wood}  🪨 ${res.stone}  💎 ${res.crystal}  '
                    '🍖 ${res.food}  🪙 ${res.gold}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(islandResourcesDaoProvider).addResources(
                            wood: 5,
                            stone: 3,
                            food: 2,
                          );
                    },
                    child: const Text('Add Resources (+5 wood, +3 stone, +2 food)'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
