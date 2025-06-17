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
            // Bot image
            Image.asset(bot.image, height: 180),

            const SizedBox(height: 8),

            // Head-to-head placeholder
            const Text(
              'Head-to-Head: 0 - 0',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 16),

            // Bot description
            Text(
              bot.description,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // MCAT Score
            Text(
              'MCAT Score: ${bot.score}',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(height: 12),

            // Bot backstory
            Text(
              bot.backstory,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Play Button
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

            const SizedBox(height: 16),

            // Achievements Button (placeholder)
            SizedBox(
              width: 60,
              height: 60,
              child: OutlinedButton(
                onPressed: () {
                  // TODO: Navigate to achievements page
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: const Color(0xFF3F3D3D),
                  padding: EdgeInsets.zero,
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.amber,
                  size: 32
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
