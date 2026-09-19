import 'package:flutter/material.dart';

import '../rendering/colorblind_overlay.dart';

/// Bottom palette bar overlay — shows available color slots for the level.
///
/// The player taps a slot to select it, then taps regions on the canvas
/// that require that palette slot to fill them.
///
/// This is a Flutter widget overlaid on the Flame GameWidget (not a
/// Flame component) so it benefits from Material Design widgets.
class PaletteBar extends StatelessWidget {
  /// Available palette slots (sorted).
  final List<int> paletteSlots;

  /// Map of palette slot → display color.
  final Map<int, Color> paletteColors;

  /// Currently selected slot.
  final int selectedSlot;

  /// Callback when a slot is tapped.
  final ValueChanged<int> onSlotSelected;

  /// Current fill progress (filled / total).
  final int filledCount;
  final int totalCount;

  /// Whether colorblind mode pattern symbols are displayed on slots.
  final bool colorblindMode;

  const PaletteBar({
    super.key,
    required this.paletteSlots,
    required this.paletteColors,
    required this.selectedSlot,
    required this.onSlotSelected,
    this.filledCount = 0,
    this.totalCount = 0,
    this.colorblindMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalCount > 0 ? filledCount / totalCount : 0.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.0),
            Colors.black.withValues(alpha: 0.7),
            Colors.black.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(
                  progress >= 1.0
                      ? const Color(0xFFA6E3A1) // green when complete
                      : const Color(0xFF89B4FA), // blue in progress
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Progress text
            Text(
              '$filledCount / $totalCount',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            // Palette slots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: paletteSlots.map((slot) {
                final color = paletteColors[slot] ?? Colors.grey;
                final isSelected = slot == selectedSlot;

                final IconData? iconData = colorblindMode
                    ? ColorblindSymbols.getIconForSlot(slot)
                    : (isSelected ? Icons.brush : null);

                return GestureDetector(
                  onTap: () => onSlotSelected(slot),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: isSelected ? 52 : 44,
                    height: isSelected ? 52 : 44,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        width: isSelected ? 3 : 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: iconData != null
                        ? Icon(
                            iconData,
                            color: Colors.white,
                            size: isSelected ? 22 : 18,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
