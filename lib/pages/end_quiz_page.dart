// End Quiz Page

import 'dart:math';
import 'package:bot_demo/models/bot.dart';
import 'package:bot_demo/resources/achievements.dart';
import 'package:flutter/material.dart';

class EndQuizPage extends StatelessWidget {
  final Bot bot;
  final int score;
  final int total;
  final Duration timeTaken;

  const EndQuizPage({
    super.key,
    required this.bot,
    required this.score,
    required this.total,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    final int minutes = timeTaken.inMinutes;
    final int seconds = timeTaken.inSeconds % 60;
    final int botScore = Random().nextInt(total + 1); // Random score from 0 to total

    // Evaluate achievements based on current performance
    final List<Map<String, String>> earnedAchievements = ACHIEVEMENTS
        .where((a) => a.shouldAward(
      score: score,
      total: total,
      timeTaken: timeTaken,
      botScore: botScore,
    ))
        .map((a) => {
      'title': a.title,
      'subtitle': a.subtitle,
    })
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MCAT Bots',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ),
        actions: const [Icon(Icons.search, color: Colors.white)],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3F3D3D),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        onTap: (index) {},
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: 'Study'),
          BottomNavigationBarItem(icon: Icon(Icons.line_weight), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.stadium), label: 'Compete'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        bot.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: MediaQuery.of(context).size.width - 140,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Dialogue',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F3D3D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score: $score / $total',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time Taken: ${minutes}m ${seconds}s',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bot Score: $botScore / $total',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('💰', style: TextStyle(fontSize: 30)),
                      Text('+100 Coins', style: TextStyle(color: Colors.green)),
                      Text('Total: 1450', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('📓', style: TextStyle(fontSize: 30)),
                      Text('+2 MCAT score', style: TextStyle(color: Colors.green)),
                      Text('Total: 515', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              if (earnedAchievements.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Achievements Unlocked',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                Column(
                  children: earnedAchievements.map((achievement) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        leading: const Icon(Icons.emoji_events, color: Colors.amber),
                        title: Text(
                          achievement['title']!,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          achievement['subtitle']!,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        tileColor: const Color(0xFF3F3D3D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () =>
                    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFF3F3D3D),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.home, color: Colors.white),
                label: const Text('Home', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
