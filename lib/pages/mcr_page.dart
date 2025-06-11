import 'package:flutter/material.dart';

class McrPage extends StatelessWidget {
  const McrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MCAT Bots',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      body: const Text(
        'MCR Page',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3F3D3D),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        onTap: (index) {
          // Handle item taps here
          print("Selected Index: $index");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_weight),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium),
            label: 'Compete',
          )
        ],
      ),
    );
  }
}
