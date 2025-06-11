import 'package:bot_demo/pages/bot_page.dart';
import 'package:bot_demo/pages/mcr_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BotPage(),
      routes: {
        '/botpage': (context) => const BotPage(),
        '/botmcr': (context) => const McrPage()
      },
    );
  }
}
