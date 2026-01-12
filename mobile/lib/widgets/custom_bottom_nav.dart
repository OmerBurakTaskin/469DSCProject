import 'dart:ui'; // BackdropFilter için gerekli
import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur efekti
        child: Container(
          height: 80, // h-20
          decoration: BoxDecoration(
            color: (isDark ? Colors.grey[800] : Colors.white)?.withOpacity(0.8),
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.grey[700]! : Colors.grey[200]!,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, 0, Icons.home, "Home"),
              _buildNavItem(context, 1, Icons.groups, "Patients"),
              _buildNavItem(context, 2, Icons.calendar_month, "Schedule"),
              _buildNavItem(context, 3, Icons.settings, "Settings"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, int index, IconData icon, String label) {
    final isSelected = selectedIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Aktif renk Primary, pasif renk Secondary
    final color = isSelected
        ? AppTheme.primary
        : (isDark ? AppTheme.secondaryDark : AppTheme.secondaryLight);

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
