import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:colorverse/coloring/palette_bar.dart';
import 'package:colorverse/core/haptics.dart';
import 'package:colorverse/core/progression_controller.dart';
import 'package:colorverse/core/providers.dart';
import 'package:colorverse/engine/colorverse_game.dart';
import 'package:colorverse/engine/level_loader.dart';
import 'package:colorverse/ui/settings_screen.dart';

/// Flutter screen that hosts the Flame GameWidget with palette bar overlay.
///
/// Uses FutureBuilder to load the level asynchronously, showing a
/// loading screen while assets are decoded in the background isolate.
class GameScreen extends ConsumerStatefulWidget {
  final String levelId;

  const GameScreen({super.key, required this.levelId});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  ColorVerseGame? _game;
  bool _isLoading = true;
  String? _error;
  int _selectedSlot = 1;
  int _filledCount = 0;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    try {
      // 1. Fetch saved progress for mid-level resume (§8)
      final progressDao = ref.read(levelProgressDaoProvider);
      final filledIdsList = await progressDao.getFilledRegionIds(widget.levelId);
      final restoredFills = filledIdsList.toSet();

      // 2. Fetch initial player settings for haptics & colorblind mode
      final profileDao = ref.read(playerProfileDaoProvider);
      final profile = await profileDao.getProfile();
      GameHaptics.enabled = profile.hapticsOn;

      // 3. Load level & decode mask in background isolate
      final game = await LevelLoader.load(
        widget.levelId,
        restoredFills: restoredFills,
        colorblindMode: profile.colorblindMode,
      );

      // Wire up incremental persistence callback
      game.onPersistFill = (regionId) async {
        await ref
            .read(levelProgressDaoProvider)
            .markRegionFilled(widget.levelId, regionId);
      };

      // Wire up game event callbacks
      game.onGameEvent = _handleGameEvent;

      // Set initial palette slot
      final slots = game.fillController.paletteSlots;
      if (slots.isNotEmpty) {
        _selectedSlot = slots.first;
        game.selectedPaletteSlot = _selectedSlot;
      }

      setState(() {
        _game = game;
        _isLoading = false;
        _totalCount = game.fillController.totalRegions;
        _filledCount = game.fillController.filledRegions;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _handleGameEvent(String event, Map<String, dynamic> data) {
    switch (event) {
      case 'fill':
        GameHaptics.lightTap();
        setState(() {
          _filledCount = data['filledCount'] as int;
          _totalCount = data['totalCount'] as int;
        });
      case 'complete':
        GameHaptics.heavyImpact();
        final stars = ProgressionController.calculateStarRating(_filledCount, _totalCount);
        ref.read(levelProgressDaoProvider).markCompleted(widget.levelId, stars);
        if (_game != null) {
          ProgressionController.grantRewards(
            rewards: _game!.level.completionRewards,
            profileDao: ref.read(playerProfileDaoProvider),
            resourcesDao: ref.read(islandResourcesDaoProvider),
          );
        }
        _showCompletionDialog();
      case 'hiddenEvent':
        GameHaptics.lightTap();
        _showHiddenEventReveal(data['eventId'] as String);
      case 'fillFailed':
        GameHaptics.mediumTap();
        break;
    }
  }

  void _showHiddenEventReveal(String eventId) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Text('✨ ', style: TextStyle(fontSize: 20)),
            Text(
              'Hidden event discovered!',
              style: const TextStyle(
                color: Color(0xFFA6E3A1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF313244),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showCompletionDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Row(
          children: [
            Text('🎉 ', style: TextStyle(fontSize: 28)),
            Text(
              'Level Complete!',
              style: TextStyle(
                color: Color(0xFFA6E3A1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _game?.level.displayName ?? 'Unknown Level',
              style: const TextStyle(
                color: Color(0xFFCDD6F4),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rewardChip('🪙', '${_game?.level.completionRewards.coins ?? 0}'),
                const SizedBox(width: 12),
                _rewardChip('💎', '${_game?.level.completionRewards.gems ?? 0}'),
                const SizedBox(width: 12),
                _rewardChip('⭐', '${_game?.level.completionRewards.xp ?? 0}'),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA6E3A1),
              foregroundColor: const Color(0xFF1E1E2E),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Widget _rewardChip(String emoji, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$emoji $amount',
        style: const TextStyle(
          color: Color(0xFFCDD6F4),
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(playerProfileProvider);
    final colorblindMode = profileAsync.valueOrNull?.colorblindMode ?? false;
    final hapticsOn = profileAsync.valueOrNull?.hapticsOn ?? true;
    final soundOn = profileAsync.valueOrNull?.soundOn ?? true;

    // Sync haptics, sound & colorblind mode settings dynamically
    GameHaptics.enabled = hapticsOn;
    if (_game != null) {
      _game!.colorblindMode = colorblindMode;
      _game!.audioManager.soundEnabled = soundOn;
    }

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF1E1E2E),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF89B4FA)),
              SizedBox(height: 16),
              Text(
                'Loading level...',
                style: TextStyle(color: Color(0xFF6C7086), fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1E1E2E),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Color(0xFFF38BA8), size: 48),
              const SizedBox(height: 16),
              Text(
                'Failed to load level',
                style: const TextStyle(color: Color(0xFFCDD6F4), fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Color(0xFF6C7086), fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF11111B),
      body: Stack(
        children: [
          // Flame game canvas (full screen)
          Positioned.fill(
            child: GameWidget(game: _game!),
          ),
          // Top bar with back button, level name, and settings
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.black.withValues(alpha: 0.0),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        _game?.level.displayName ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined, color: Colors.white),
                      onPressed: () {
                        GameHaptics.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom palette bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: PaletteBar(
              paletteSlots: _game?.fillController.paletteSlots ?? [],
              paletteColors: {
                for (final slot in _game?.fillController.paletteSlots ?? <int>[])
                  slot: _game?.fillController.getPaletteColor(slot) ??
                      const Color(0xFF888888),
              },
              selectedSlot: _selectedSlot,
              colorblindMode: colorblindMode,
              onSlotSelected: (slot) {
                GameHaptics.selectionClick();
                setState(() => _selectedSlot = slot);
                _game?.selectedPaletteSlot = slot;
              },
              filledCount: _filledCount,
              totalCount: _totalCount,
            ),
          ),
        ],
      ),
    );
  }
}
