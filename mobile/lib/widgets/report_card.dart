import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';

enum ReportStatus { complete, draft }

class ReportCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final ReportStatus status;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Duruma göre renkleri belirle
    final isComplete = status == ReportStatus.complete;
    final statusBgColor = isComplete
        ? (isDark ? AppTheme.emerald900.withOpacity(0.5) : AppTheme.emerald50)
        : (isDark ? AppTheme.amber900.withOpacity(0.5) : AppTheme.amber50);

    final statusTextColor = isComplete
        ? (isDark ? const Color(0xFF34D399) : AppTheme.emeraldText)
        : (isDark ? const Color(0xFFFBBF24) : AppTheme.amberText);

    final statusText = isComplete ? "Complete" : "Draft";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1F2937)
              : Colors.white, // gray-800 : white
          borderRadius: BorderRadius.circular(12), // rounded-xl
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Status Badge & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    statusText.toUpperCase(),
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 10, // text-xs
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5, // tracking-wider
                    ),
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: isDark
                        ? AppTheme.secondaryDark
                        : AppTheme.secondaryLight,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              title,
              style: TextStyle(
                color: isDark ? AppTheme.textDark : AppTheme.textLight,
                fontSize: 18, // text-lg
                fontWeight: FontWeight.bold,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(height: 4),
            // Description
            Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    isDark ? AppTheme.secondaryDark : AppTheme.secondaryLight,
                fontSize: 14, // text-sm
                height: 1.5, // leading-normal
              ),
            ),
          ],
        ),
      ),
    );
  }
}
