import 'dart:math';
import 'package:bot_demo/components/bot_app_bar.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';

class EndQuizPage extends StatelessWidget {
  final Bot bot;
  final int score;
  final int total;
  final Duration timeTaken;
  final int playerMcat; // passed from quiz page

  const EndQuizPage({
    super.key,
    required this.bot,
    required this.score,
    required this.total,
    required this.timeTaken,
    required this.playerMcat,
  });

  int calculateEloDelta({
    required int playerScore,
    required int botScore,
    required int totalQuestions,
    required int playerMCAT,
    required int botMCAT,
    required double avgTime,
  }) {
    double accuracy = playerScore / totalQuestions;
    double botAccuracy = botScore / totalQuestions;
    double speedScore = (25 - avgTime) / 25;
    if (speedScore < 0) speedScore = 0;

    String result;
    if (playerScore > botScore) result = "win";
    else if (playerScore < botScore) result = "lose";
    else result = "tie";

    int eloDiff = botMCAT - playerMCAT;
    double baseWeight;
    if (eloDiff.abs() >= 20) {
      baseWeight = eloDiff > 0 ? 1.0 : 0.0;
    } else {
      baseWeight = 0.5 + (eloDiff / 40.0);
    }

    double performanceScore = (accuracy * 0.7) + (speedScore * 0.3);
    double delta = 0;
    if (result == "win") {
      delta = 10 * baseWeight * performanceScore;
    } else if (result == "lose") {
      delta = -10 * (1 - baseWeight) * (1 - performanceScore);
    }

    delta = delta.clamp(-10, 10).roundToDouble();
    return delta.toInt();
  }

  String getBotComment(String result) {
    // Later: pull from bots.dart "comments" map
    if (result == "win") return bot.name == 'CRISPR Cassie IX'
        ? "Genetic perfection achieved!"
        : "You've bested me this time...";
    if (result == "lose") return "Flawless victory. Train harder!";
    return "A tie! Well played.";
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = timeTaken.inMinutes;
    final int seconds = timeTaken.inSeconds % 60;

    final int botMCAT = int.tryParse(bot.score.replaceAll("?", "")) ?? 520;
    final int botScore = Random().nextInt(total + 1); // Placeholder bot perf

    final double avgTime = timeTaken.inSeconds / total;
    final int eloDelta = calculateEloDelta(
      playerScore: score,
      botScore: botScore,
      totalQuestions: total,
      playerMCAT: playerMcat,
      botMCAT: botMCAT,
      avgTime: avgTime,
    );

    final int finalMcat = (playerMcat + eloDelta).clamp(490, 530);
    final bool win = score > botScore;
    final bool lose = score < botScore;

    final int coinsEarned = win ? 25 : 0;

    String resultText = "tie";
    if (win) resultText = "win";
    if (lose) resultText = "lose";

    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: const BotAppBar(name: 'MCAT Bots'),
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
        child: Padding(
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
                      child: Image.asset(bot.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        getBotComment(resultText),
                        textAlign: TextAlign.center,
                      ),
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
                    Text('Your Score: $score / $total',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Time Taken: ${minutes}m ${seconds}s',
                        style: const TextStyle(color: Colors.white70)),
                    Text('Bot Score: $botScore / $total',
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(
                      'MCAT Change: ${eloDelta >= 0 ? "+" : ""}$eloDelta → $finalMcat',
                      style: TextStyle(
                        color: eloDelta >= 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Text('💰', style: TextStyle(fontSize: 30)),
                      Text(win ? '+$coinsEarned Coins' : '+0 Coins',
                          style: const TextStyle(color: Colors.green)),
                      const Text('Total: 1450', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('📓', style: TextStyle(fontSize: 30)),
                      Text('${eloDelta >= 0 ? "+" : ""}$eloDelta MCAT score',
                          style: TextStyle(color: eloDelta >= 0 ? Colors.green : Colors.red)),
                      Text('Total: $finalMcat', style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
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
