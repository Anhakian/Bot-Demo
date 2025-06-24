import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF3F3D3D),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      onTap: (index) {
        print("Selected Index: $index");
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Study'),
        BottomNavigationBarItem(
            icon: Icon(Icons.line_weight), label: 'Training'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Review'),
        BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'Compete'),
      ],
    );
  }
}
