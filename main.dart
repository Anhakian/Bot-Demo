
import 'package:flutter/material.dart';
import 'screens/start_screen.dart';

void main() {
  runApp(AnatomyGuesserApp());
}

class AnatomyGuesserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anatomy Guesser',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Roboto'),
      ),
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
