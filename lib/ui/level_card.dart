import 'package:flutter/material.dart';

import '../core/haptics.dart';
import '../models/models.dart';
import '../storage/database.dart';

/// Reusable level list item displaying unlock status, star rating, and difficulty.
class LevelCard extends StatelessWidget {
  final LevelManifestEntry level;
  final LevelProgressEntry? progress;
  final bool isUnlocked;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.progress,
    required this.isUnlocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final stars = progress?.starRating ?? 0;
    final isCompleted = progress?.status == 'completed';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isUnlocked ? const Color(0xFF313244) : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? const Color(0xFFA6E3A1).withValues(alpha: 0.5)
              : (isUnlocked
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.03)),
          width: isCompleted ? 2 : 1,
        ),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isUnlocked
              ? () {
                  GameHaptics.selectionClick();
                  onTap();
                }
              : () {
                  GameHaptics.mediumTap();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        level.requiredXp > 0
                            ? 'Locked: Requires ${level.requiredXp} XP'
                            : 'Locked: Complete previous level first',
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Lock / Play Icon indicator
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? (isCompleted
                            ? const Color(0xFFA6E3A1).withValues(alpha: 0.2)
                            : const Color(0xFF89B4FA).withValues(alpha: 0.2))
                        : const Color(0xFF181825),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isUnlocked
                        ? (isCompleted ? Icons.check : Icons.play_arrow)
                        : Icons.lock_outline,
                    color: isUnlocked
                        ? (isCompleted
                            ? const Color(0xFFA6E3A1)
                            : const Color(0xFF89B4FA))
                        : const Color(0xFF6C7086),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),

                // Level info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level.displayName,
                        style: TextStyle(
                          color: isUnlocked
                              ? const Color(0xFFCDD6F4)
                              : const Color(0xFF6C7086),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildDifficultyChip(level.difficulty),
                          const SizedBox(width: 8),
                          Text(
                            '${level.regionCount} regions',
                            style: TextStyle(
                              color: const Color(0xFFCDD6F4).withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Stars rating display
                if (isUnlocked && stars > 0)
                  Row(
                    children: List.generate(3, (index) {
                      return Icon(
                        index < stars ? Icons.star : Icons.star_border,
                        color: index < stars
                            ? const Color(0xFFF9E2AF)
                            : const Color(0xFF6C7086),
                        size: 18,
                      );
                    }),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    final color = switch (difficulty.toLowerCase()) {
      'easy' => const Color(0xFFA6E3A1),
      'medium' => const Color(0xFFF9E2AF),
      'hard' => const Color(0xFFF38BA8),
      _ => const Color(0xFF89B4FA),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
