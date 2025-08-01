
import 'package:flutter/material.dart';
import 'start_screen.dart';

class EndScreen extends StatelessWidget {
  final int score;
  const EndScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Game Over!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Total Score: \$score', style: TextStyle(fontSize: 24)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StartScreen()));
              },
              child: Text('Play Again'),
            )
          ],
        ),
      ),
    );
  }
}
