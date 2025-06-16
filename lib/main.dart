import 'package:bot_demo/components/router.dart';
import 'package:bot_demo/pages/bot_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BotPage(),
      initialRoute: AppRouter.myAppRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
