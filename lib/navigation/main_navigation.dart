import 'package:flutter/material.dart';
import 'package:lost_and_found_mobile/screens/my_claims/my_claims_screen.dart';
import 'package:lost_and_found_mobile/screens/post_found_item/post_found_item_screen.dart';
import 'package:lost_and_found_mobile/screens/profile/profile_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/found_items_list/found_item_list.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  static const Color primaryColor = Color(0xFF525FE1);

  final List<Widget> _pages = [
    HomeScreen(),
    FoundItemsPage(),
    MyClaimsScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        height: 64,
        width: 64,
        margin: const EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-post');
          },
          backgroundColor: primaryColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: const Icon(Icons.add, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 100,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home, 'Home'),
              _buildNavItem(1, Icons.check_circle_outline, 'Found'),
              const SizedBox(width: 40), // FAB space
              _buildNavItem(2, Icons.assignment_outlined, 'Claims'),
              _buildNavItem(3, Icons.person_outline, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : Colors.grey,
              size: 26,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? primaryColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
