class Achievement {
  final String title;
  final String subtitle;

  Achievement({required this.title, required this.subtitle});

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
    );
  }
}
