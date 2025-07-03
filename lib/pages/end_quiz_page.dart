// End Quiz Page

import 'package:bot_demo/components/bot_app_bar.dart';
import 'package:bot_demo/lib/services/flask_service.dart';
import 'package:bot_demo/models/achievement.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:bot_demo/models/end_game_result.dart';
import 'package:flutter/material.dart';

class EndQuizPage extends StatefulWidget {
  final Bot bot;
  final String sessionId;
  final int total;
  final EndGameResult endGameResult;
  final Duration timeTaken;

  const EndQuizPage({
    super.key,
    required this.bot,
    required this.sessionId,
    required this.endGameResult,
    required this.total,
    required this.timeTaken,
  });

  @override
  State<EndQuizPage> createState() => _EndQuizPageState();
}

class _EndQuizPageState extends State<EndQuizPage> {
  final FlaskService flaskService = FlaskService();

  @override
  @override
  Widget build(BuildContext context) {
    final result = widget.endGameResult.result;
    final playerCorrect = widget.endGameResult.playerCorrect;
    final botCorrect = widget.endGameResult.botCorrect;
    final accuracy = widget.endGameResult.accuracy;
    final avgTime = widget.endGameResult.avgTime;
    final delta = widget.endGameResult.delta;
    final finalScore = widget.endGameResult.finalScore;
    final coins = widget.endGameResult.coins;
    final achievements = widget.endGameResult.achievements;
    final comment = widget.endGameResult.comment;

    final List<Achievement> earnedAchievements =
        widget.endGameResult.achievements;

    final minutes = widget.timeTaken.inMinutes;
    final seconds = widget.timeTaken.inSeconds % 60;

    if (seconds < 60) {
      earnedAchievements.add(Achievement(
          title: '⏱️ Speed Demon', subtitle: 'Completed under 1 minute'));
    }
    if (playerCorrect == widget.total) {
      earnedAchievements.add(
        Achievement(
          title: '🎯 Perfect Score',
          subtitle: '${widget.total} out of ${widget.total} correct!',
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF212323),
      appBar: const BotAppBar(
        name: 'MCAT Bots',
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
          BottomNavigationBarItem(
              icon: Icon(Icons.line_weight), label: 'Training'),
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
                      child: Image.asset(
                        widget.bot.image,
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
                      'Your Score: $playerCorrect / ${widget.total}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Time Taken: ${minutes}m ${seconds}s',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bot Score: $botCorrect / ${widget.total}',
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
                      Text('Total: 1450',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('📓', style: TextStyle(fontSize: 30)),
                      Text('+2 MCAT score',
                          style: TextStyle(color: Colors.green)),
                      Text('Total: 515', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
              if (earnedAchievements.isNotEmpty) ...[
                const SizedBox(height: 20),
                const Text(
                  'Achievements Unlocked',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ClipRect(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 4),
                      physics: const ClampingScrollPhysics(),
                      itemExtent: 72,
                      itemCount: earnedAchievements.length,
                      itemBuilder: (context, index) {
                        final achievement = earnedAchievements[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF3F3D3D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              leading: const Icon(Icons.emoji_events,
                                  color: Colors.amber),
                              title: Text(
                                achievement.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                achievement.subtitle,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName('/')),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xFF3F3D3D),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.home, color: Colors.white),
                  label:
                      const Text('Home', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
