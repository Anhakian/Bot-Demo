//Achievements page

typedef AchievementEvaluator = bool Function({
required int score,
required int total,
required Duration timeTaken,
required int botScore,
});

class Achievement {
  final String title;
  final String subtitle;
  final AchievementEvaluator shouldAward;

  Achievement({
    required this.title,
    required this.subtitle,
    required this.shouldAward,
  });
}

final List<Achievement> ACHIEVEMENTS = [
  Achievement(
    title: '⏱️ Speed Demon',
    subtitle: 'Completed under 1 minute',
    shouldAward: ({required score, required total, required timeTaken, required botScore}) =>
    timeTaken.inSeconds < 60,
  ),
  Achievement(
    title: '🎯 Perfect Score',
    subtitle: 'Got every question correct!',
    shouldAward: ({required score, required total, required timeTaken, required botScore}) =>
    score == total,
  ),
  Achievement(
    title: '🤝 Equal Minds',
    subtitle: 'You tied with the bot',
    shouldAward: ({required score, required total, required timeTaken, required botScore}) =>
    score == botScore,
  ),
];
