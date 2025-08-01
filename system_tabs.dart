
import 'package:flutter/material.dart';

class SystemTabs extends StatelessWidget {
  final systems = ['Digestive', 'Circulatory', 'Nervous', 'Integumentary'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: systems.map((s) => Text(s, style: TextStyle(fontSize: 14))).toList(),
      ),
    );
  }
}
