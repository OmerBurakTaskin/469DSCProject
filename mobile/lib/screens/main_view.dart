import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/widgets/doctor_profile_card.dart';
import 'package:mobile/widgets/prescription_item.dart';
import 'package:mobile/widgets/section_card.dart';

class ConsultationSummaryScreen extends StatelessWidget {
  const ConsultationSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      // Top App Bar (Sticky effect handled by standard AppBar in Flutter)
      appBar: AppBar(
        backgroundColor: isDark
            ? AppColors.backgroundDark.withOpacity(0.9)
            : AppColors.backgroundLight.withOpacity(0.9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  isDark ? Colors.white.withOpacity(0.1) : Colors.transparent,
            ),
            child: Icon(Icons.arrow_back,
                color: isDark ? Colors.white : AppColors.slate900),
          ),
          onPressed: () {},
        ),
        title: Text(
          "Consultation Summary",
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.slate900,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: isDark ? AppColors.slate800 : AppColors.slate200,
            height: 1.0,
          ),
        ),
      ),
      // Scrollable Content
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Footer için boşluk
        child: Column(
          children: [
            // Patient Info Chip
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.slate800.withOpacity(0.5)
                      : AppColors.slate200.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(
                    color: isDark ? AppColors.slate800 : AppColors.slate200,
                  ),
                ),
                child: Text(
                  "PATIENT: JOHN DOE • ID #12345",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: isDark ? AppColors.slate400 : AppColors.slate500,
                  ),
                ),
              ),
            ),

            // 1. Profile Card
            const DoctorProfileCard(),

            // 2. Diagnosis Card
            SectionCard(
              title: "Diagnosis",
              icon:
                  Icons.monitor_heart_outlined, // Stethoscope icon alternatifi
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.coronavirus_outlined,
                          color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Acute Bronchitis",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : AppColors.slate900,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Viral infection causing inflammation of the bronchial tubes.",
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? AppColors.slate400
                                  : AppColors.slate500,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // 3. Prescriptions Card
            SectionCard(
              title: "Prescriptions",
              icon: Icons.medication_outlined,
              child: Column(
                children: [
                  const PrescriptionItem(
                    medicineName: "Amoxicillin",
                    dosage: "500MG",
                    instructions: "Take 1 tablet every 8 hours with food.",
                    duration: "5 days",
                    icon: Icons.science, // Pill icon alternatifi
                    iconBgColor: Color(0xFFEFF6FF), // blue-50
                    iconColor: Color(0xFF2563EB), // blue-600
                  ),
                  Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: AppColors.slate100),
                  const PrescriptionItem(
                    medicineName: "Cough Syrup",
                    dosage: "10ML",
                    instructions: "Take 10ml before bed to suppress coughing.",
                    duration: "",
                    icon: Icons.water_drop, // Liquid icon alternatifi
                    iconBgColor: Color(0xFFFAF5FF), // purple-50
                    iconColor: Color(0xFF9333EA), // purple-600
                  ),
                ],
              ),
            ),

            // 4. Notes Card
            SectionCard(
              title: "Doctor's Notes",
              icon: Icons.notes,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildNoteItem(
                        1, "Drink plenty of fluids to stay hydrated.", isDark),
                    const SizedBox(height: 12),
                    _buildNoteItem(
                        2,
                        "Avoid smoking or exposure to secondhand smoke.",
                        isDark),
                    const SizedBox(height: 12),
                    _buildNoteItem(
                        3,
                        "Follow up in 7 days if symptoms do not improve or worsen.",
                        isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Footer Actions (Fixed Bottom)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.slate900 : Colors.white,
          border: Border(
              top: BorderSide(
                  color: isDark ? AppColors.slate800 : AppColors.slate200)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 6,
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.save_alt),
                  label: const Text("Save Report"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        isDark ? AppColors.slate200 : AppColors.slate900,
                    side: BorderSide(
                        color:
                            isDark ? AppColors.slate500 : AppColors.slate200),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Back to Home"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Note Item Widget Helper (Private widget)
  Widget _buildNoteItem(int number, String text, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: isDark ? AppColors.slate200 : AppColors.slate500,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
