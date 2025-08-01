
import 'package:flutter/material.dart';
import '../widgets/system_tabs.dart';
import 'end_screen.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> questions = [
    {
      'prompt': 'What organ is affected by cirrhosis?',
      'system': 'Digestive',
      'image': 'digestive.png',
      'answer': Offset(420, 280)
    },
    {
      'prompt': 'Where is the aorta located?',
      'system': 'Circulatory',
      'image': 'circulatory.png',
      'answer': Offset(390, 240)
    },
    {
      'prompt': 'Which organ pumps blood around the body?',
      'system': 'Circulatory',
      'image': 'circulatory.png',
      'answer': Offset(400, 300)
    },
    {
      'prompt': 'Which organ controls the nervous system?',
      'system': 'Nervous',
      'image': 'nervous.png',
      'answer': Offset(400, 120)
    }
  ];

  int currentQuestion = 0;
  int totalScore = 0;
  Offset? userTap;

  void handleTap(TapUpDetails details, BuildContext context, Size imageSize) {
    final tapPos = details.localPosition;
    final answer = questions[currentQuestion]['answer'] as Offset;
    final distance = (tapPos - answer).distance;

    int score = 0;
    if (distance < 80) {
      score = 1000 - ((distance / 80) * 300).toInt();
    }

    setState(() {
      totalScore += score;
      userTap = tapPos;
    });

    Future.delayed(Duration(seconds: 1), () {
      if (currentQuestion + 1 < questions.length) {
        setState(() {
          currentQuestion++;
          userTap = null;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EndScreen(score: totalScore),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final imagePath = 'assets/' + question['image'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestion + 1}/5'),
        actions: [Padding(padding: EdgeInsets.all(12), child: Center(child: Text('Score: \$totalScore')))],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              question['prompt'],
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final imageSize = Size(constraints.maxWidth, constraints.maxHeight);
                return GestureDetector(
                  onTapUp: (details) => handleTap(details, context, imageSize),
                  child: Stack(
                    children: [
                      Image.asset(imagePath, width: imageSize.width, height: imageSize.height, fit: BoxFit.cover),
                      if (userTap != null)
                        Positioned(
                          left: userTap!.dx - 8,
                          top: userTap!.dy - 8,
                          child: Icon(Icons.location_on, color: Colors.blue, size: 24),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          SystemTabs(),
        ],
      ),
    );
  }
}
