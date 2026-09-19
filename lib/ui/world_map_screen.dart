import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/haptics.dart';
import '../core/progression_controller.dart';
import '../core/providers.dart';
import '../models/models.dart';
import 'game_screen.dart';
import 'level_card.dart';
import 'settings_screen.dart';
import 'store_screen.dart';

/// Main World Map screen hosting world biomes, level selection, and progression.
class WorldMapScreen extends ConsumerStatefulWidget {
  const WorldMapScreen({super.key});

  @override
  ConsumerState<WorldMapScreen> createState() => _WorldMapScreenState();
}

class _WorldMapScreenState extends ConsumerState<WorldMapScreen>
    with SingleTickerProviderStateMixin {
  WorldManifest? _manifest;
  bool _isLoading = true;
  String? _error;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _loadManifest();
  }

  Future<void> _loadManifest() async {
    try {
      final jsonStr = await rootBundle.loadString('assets/worlds.json');
      final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
      final manifest = WorldManifest.fromJson(jsonMap);

      _tabController = TabController(
        length: manifest.worlds.length,
        vsync: this,
      );

      setState(() {
        _manifest = manifest;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(playerProfileProvider);
    final progressAsync = ref.watch(allLevelProgressProvider);

    final playerXp = profileAsync.valueOrNull?.xp ?? 0;
    final playerLevel = ProgressionController.calculatePlayerLevel(playerXp);
    final xpProgress = ProgressionController.calculateLevelProgress(playerXp);

    final progressEntries = progressAsync.valueOrNull ?? [];
    final progressMap = {for (final p in progressEntries) p.levelId: p};
    final completedIds = progressEntries
        .where((p) => p.status == 'completed')
        .map((p) => p.levelId)
        .toSet();

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1E1E2E),
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF89B4FA)),
        ),
      );
    }

    if (_error != null || _manifest == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1E1E2E),
        body: Center(
          child: Text(
            'Error loading worlds: $_error',
            style: const TextStyle(color: Color(0xFFF38BA8)),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF181825),
      appBar: AppBar(
        backgroundColor: const Color(0xFF11111B),
        elevation: 0,
        title: Row(
          children: [
            // Player level avatar chip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF89B4FA).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF89B4FA)),
              ),
              child: Text(
                'Lvl $playerLevel',
                style: const TextStyle(
                  color: Color(0xFF89B4FA),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Currencies display
            profileAsync.when(
              data: (p) => Row(
                children: [
                  Text('🪙 ${p.coins}',
                      style: const TextStyle(
                          color: Color(0xFFCDD6F4), fontSize: 13)),
                  const SizedBox(width: 8),
                  Text('💎 ${p.gems}',
                      style: const TextStyle(
                          color: Color(0xFFCDD6F4), fontSize: 13)),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (err, st) => const SizedBox.shrink(),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.storefront_outlined, color: Color(0xFFF9E2AF)),
            onPressed: () {
              GameHaptics.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StoreScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFFCDD6F4)),
            onPressed: () {
              GameHaptics.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Column(
            children: [
              // XP Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: xpProgress,
                    minHeight: 4,
                    backgroundColor: Colors.white.withValues(alpha: 0.1),
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFCBA6F7)),
                  ),
                ),
              ),
              // World Tabs
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: const Color(0xFFA6E3A1),
                labelColor: const Color(0xFFA6E3A1),
                unselectedLabelColor: const Color(0xFF6C7086),
                tabs: _manifest!.worlds.map((w) {
                  return Tab(text: w.displayName);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _manifest!.worlds.map((world) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: world.levels.length,
            itemBuilder: (ctx, index) {
              final levelEntry = world.levels[index];
              final progressEntry = progressMap[levelEntry.levelId];
              final isUnlocked = ProgressionController.isLevelUnlocked(
                level: levelEntry,
                playerXp: playerXp,
                completedLevelIds: completedIds,
              );

              return LevelCard(
                level: levelEntry,
                progress: progressEntry,
                isUnlocked: isUnlocked,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameScreen(levelId: levelEntry.levelId),
                    ),
                  );
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
