import 'package:bot_demo/models/achievement.dart';

class EndGameResult {
  final String result;
  final int playerCorrect;
  final int botCorrect;
  final double accuracy;
  final double avgTime;
  final int delta;
  final int finalScore;
  final int coins;
  final List<Achievement> achievements;
  final String comment;

  EndGameResult({
    required this.result,
    required this.playerCorrect,
    required this.botCorrect,
    required this.accuracy,
    required this.avgTime,
    required this.delta,
    required this.finalScore,
    required this.coins,
    required this.achievements,
    required this.comment,
  });

  factory EndGameResult.fromJson(Map<String, dynamic> json) {
    return EndGameResult(
      result: json['result'] ?? '',
      playerCorrect: json['player_correct'] ?? 0,
      botCorrect: json['bot_correct'] ?? 0,
      accuracy: (json['accuracy'] ?? 0).toDouble(),
      avgTime: (json['avg_time'] ?? 0).toDouble(),
      delta: json['delta'] ?? 0,
      finalScore: json['final_score'] ?? 0,
      coins: json['coins'] ?? 0,
      achievements: List<Achievement>.from(json['achievements'] ?? []),
      comment: json['comment'] ?? '',
    );
  }
}
