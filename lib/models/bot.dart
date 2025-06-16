class Bot {
  final String image;
  final String name;
  final String description;
  final String backstory;
  final String score;

  const Bot({
    required this.image,
    required this.name,
    required this.description,
    required this.backstory,
    required this.score,
  });

  factory Bot.fromMap(Map<String, dynamic> map) {
    return Bot(
      image: map['image'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      backstory: map['backstory'] ?? '',
      score: map['score'] ?? '',
    );
  }
}
