import 'package:flutter/material.dart';
import 'package:jalan_in/core/theme/app_theme.dart';
import 'package:jalan_in/views/auth/map_screen.dart';
import 'package:jalan_in/views/profile/profile_screen.dart';
import 'package:jalan_in/views/report/report_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(),
    const ReportScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppTheme.backgroundColor,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: _currentIndex == 0
                    ? BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                child: Icon(
                  Icons.map_outlined,
                  color: _currentIndex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'PETA',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: _currentIndex == 1
                    ? BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: _currentIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'LAPOR',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: _currentIndex == 2
                    ? BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      )
                    : null,
                child: Icon(
                  Icons.person_outline,
                  color: _currentIndex == 2 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'PROFIL',
            ),
          ],
        ),
      ),
    );
  }
}

