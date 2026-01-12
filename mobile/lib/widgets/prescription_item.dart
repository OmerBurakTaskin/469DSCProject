import 'package:flutter/material.dart';
import "package:mobile/core/theme/app_colors.dart";

class PrescriptionItem extends StatelessWidget {
  final String medicineName;
  final String dosage;
  final String instructions;
  final String duration;
  final Color iconBgColor;
  final Color iconColor;
  final IconData icon;

  const PrescriptionItem({
    super.key,
    required this.medicineName,
    required this.dosage,
    required this.instructions,
    required this.duration,
    required this.iconBgColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      medicineName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : AppColors.slate900,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.slate800 : AppColors.slate100,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        dosage,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              isDark ? AppColors.slate200 : AppColors.slate500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  instructions,
                  style: TextStyle(
                    color: isDark ? AppColors.slate400 : AppColors.slate500,
                    fontSize: 14,
                  ),
                ),
                if (duration.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.slate800 : AppColors.slate50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.schedule,
                            size: 14, color: AppColors.slate400),
                        const SizedBox(width: 4),
                        Text(
                          duration,
                          style: TextStyle(
                              color: AppColors.slate400, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
