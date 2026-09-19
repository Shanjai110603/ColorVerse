import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/haptics.dart';
import '../core/providers.dart';

/// User settings screen allowing toggling of accessibility and audio options.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(playerProfileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181825),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Color(0xFFCDD6F4),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFCDD6F4)),
        elevation: 0,
      ),
      body: profileAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF89B4FA)),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error: $err',
            style: const TextStyle(color: Color(0xFFF38BA8)),
          ),
        ),
        data: (profile) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  'Accessibility & Controls',
                  style: TextStyle(
                    color: Color(0xFF89B4FA),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildSettingCard(
                title: 'Colorblind Mode',
                subtitle:
                    'Display pattern symbols on colored regions for non-color identification',
                icon: Icons.visibility_outlined,
                value: profile.colorblindMode,
                onChanged: (val) {
                  GameHaptics.selectionClick();
                  ref.read(playerProfileDaoProvider).updateSettings(
                        colorblindMode: val,
                      );
                },
              ),
              const SizedBox(height: 12),
              _buildSettingCard(
                title: 'Haptic Feedback',
                subtitle: 'Vibrate on tap actions, wrong selections, and triggers',
                icon: Icons.vibration,
                value: profile.hapticsOn,
                onChanged: (val) {
                  GameHaptics.enabled = val;
                  if (val) GameHaptics.lightTap();
                  ref.read(playerProfileDaoProvider).updateSettings(
                        hapticsOn: val,
                      );
                },
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Text(
                  'Audio',
                  style: TextStyle(
                    color: Color(0xFF89B4FA),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildSettingCard(
                title: 'Sound Effects & Music',
                subtitle: 'Enable or disable in-game audio triggers and ambient music',
                icon: Icons.volume_up_outlined,
                value: profile.soundOn,
                onChanged: (val) {
                  GameHaptics.selectionClick();
                  ref.read(playerProfileDaoProvider).updateSettings(
                        soundOn: val,
                      );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: const Color(0xFFCBA6F7)),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFCDD6F4),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: const Color(0xFFCDD6F4).withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
        value: value,
        activeThumbColor: const Color(0xFFA6E3A1),
        activeTrackColor: const Color(0xFFA6E3A1).withValues(alpha: 0.3),
        inactiveThumbColor: const Color(0xFF6C7086),
        inactiveTrackColor: const Color(0xFF1E1E2E),
        onChanged: onChanged,
      ),
    );
  }
}
