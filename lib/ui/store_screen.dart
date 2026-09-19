import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/haptics.dart';
import '../core/providers.dart';

/// IAP store screen for purchasing entitlements and currency packs.
class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(playerProfileProvider);
    final entitlementsAsync = ref.watch(allEntitlementsProvider);

    final activeSkus = entitlementsAsync.valueOrNull
            ?.where((e) => e.active)
            .map((e) => e.sku)
            .toSet() ??
        {};

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181825),
        title: const Text(
          'ColorVerse Store',
          style: TextStyle(
            color: Color(0xFFCDD6F4),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFCDD6F4)),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Currency balance header
          profileAsync.when(
            data: (p) => Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF313244),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _currencyCounter('🪙', '${p.coins}', 'Coins'),
                  _currencyCounter('💎', '${p.gems}', 'Gems'),
                ],
              ),
            ),
            loading: () => const SizedBox.shrink(),
            error: (err, st) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 24),

          const Text(
            'Special Offers',
            style: TextStyle(
              color: Color(0xFF89B4FA),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          _buildStoreTile(
            title: 'Remove Ads',
            subtitle: 'Enjoy an ad-free coloring experience forever',
            icon: Icons.block,
            price: '\$2.99',
            isPurchased: activeSkus.contains('remove_ads'),
            onTap: () async {
              GameHaptics.heavyImpact();
              await ref
                  .read(entitlementDaoProvider)
                  .recordPurchase('remove_ads');
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🎉 Ads Removed Successfully!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 24),
          const Text(
            'Gem Packs',
            style: TextStyle(
              color: Color(0xFF89B4FA),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          _buildStoreTile(
            title: '100 Gems',
            subtitle: 'Handful of shiny gems for hints & power-ups',
            icon: Icons.diamond_outlined,
            price: '\$0.99',
            onTap: () async {
              GameHaptics.selectionClick();
              await ref.read(playerProfileDaoProvider).addGems(100);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('💎 100 Gems added!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 12),
          _buildStoreTile(
            title: '500 Gems',
            subtitle: 'Chest of gems (+20% bonus value)',
            icon: Icons.workspace_premium,
            price: '\$3.99',
            onTap: () async {
              GameHaptics.heavyImpact();
              await ref.read(playerProfileDaoProvider).addGems(500);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('💎 500 Gems added!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _currencyCounter(String emoji, String amount, String label) {
    return Column(
      children: [
        Text(
          '$emoji $amount',
          style: const TextStyle(
            color: Color(0xFFCDD6F4),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFFCDD6F4).withValues(alpha: 0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStoreTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required String price,
    bool isPurchased = false,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF313244),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFF9E2AF), size: 32),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFCDD6F4),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: const Color(0xFFCDD6F4).withValues(alpha: 0.6),
            fontSize: 12,
          ),
        ),
        trailing: isPurchased
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFA6E3A1).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Color(0xFFA6E3A1),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            : ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF89B4FA),
                  foregroundColor: const Color(0xFF1E1E2E),
                ),
                child: Text(price),
              ),
      ),
    );
  }
}
