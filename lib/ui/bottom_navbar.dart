import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color(0xff007BFF),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(icon: _buildIcon(Icons.home, 0), label: "Home"),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.science_outlined, 1),
          label: "Combination",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(Icons.person, 2),
          label: "Profile",
        ),
      ],
    );
  }

  /// Helper widget to add a blue line above the active icon
  Widget _buildIcon(IconData icon, int index) {
    final bool isActive = currentIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Blue line above the active icon
        Container(
          height: 3,
          width: 24,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff007BFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 4),
        Icon(icon),
      ],
    );
  }
}
