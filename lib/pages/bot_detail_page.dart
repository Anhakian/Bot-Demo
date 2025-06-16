import 'package:bot_demo/components/router.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';

class BotDetailPage extends StatelessWidget {
  final Bot bot;

  const BotDetailPage({
    super.key,
    required this.bot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(bot.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 96.0, left: 24.0, right: 24.0, bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(bot.image, height: 180),
            const SizedBox(height: 16),
            Text(
              bot.description,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              'MCAT Score: ${bot.score}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              bot.backstory,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.botQuizRoute,
                    arguments: bot,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3F3D3D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
