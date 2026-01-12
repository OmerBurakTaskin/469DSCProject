import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/widgets/report_card.dart';
import 'package:mobile/widgets/custom_bottom_nav.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.backgroundDark : AppTheme.backgroundLight,
      extendBody:
          true, // Body'nin bottom nav arkasına uzanmasını sağlar (blur için)

      // Top App Bar
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        elevation: 1,
        titleSpacing: 0,
        toolbarHeight: 64, // h-16 (64px)
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 40, // size-10
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://i.pravatar.cc/150?img=11"), // Placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Title
              Expanded(
                child: Text(
                  "Consultations",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppTheme.textLight,
                    fontSize: 20, // text-xl
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Search Button
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.search, size: 28),
                  color: AppTheme.textLight,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),

      // Main Content List
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
            16, 16, 16, 100), // Bottom nav için alt boşluk
        children: [
          ReportCard(
            status: ReportStatus.complete,
            date: "April 26, 2024",
            title: "Follow-up with Patient Name",
            description:
                "Patient reports improved symptoms following the new medication regimen. Vitals are stable...",
            onTap: () {
              // Navigation logic to Summary Screen
              print("Clicked Card 1");
            },
          ),
          ReportCard(
            status: ReportStatus.draft,
            date: "April 22, 2024",
            title: "Initial Consultation: John Doe",
            description:
                "Patient presents with persistent headaches and mild dizziness. Initial examination suggests...",
            onTap: () {},
          ),
          ReportCard(
            status: ReportStatus.complete,
            date: "April 19, 2024",
            title: "Routine Check-up: Jane Smith",
            description:
                "Annual physical examination. All vitals are within normal ranges. Discussed importance of...",
            onTap: () {},
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 80.0), // Nav bar'ın üstünde kalması için
        child: SizedBox(
          width: 56, // size-14
          height: 56,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppTheme.primary,
            elevation: 4,
            shape: const CircleBorder(), // Tam yuvarlak
            child: const Icon(Icons.add, size: 30, color: AppTheme.textLight),
          ),
        ),
      ),

      // Bottom Navigation
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _currentNavIndex,
        onItemSelected: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }
}
