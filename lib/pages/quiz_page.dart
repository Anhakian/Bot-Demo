import 'package:bot_demo/components/dialogue_box.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';

import '../resources/questions.dart';

class QuizScreen extends StatefulWidget {
  final Bot bot;

  const QuizScreen({
    super.key,
    required this.bot,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late DateTime startTime;
  static final int NUM_QUESTIONS = 5;
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  TextEditingController textController = TextEditingController();
  int score = 0;
  bool isAnswered = false;

  late List<Map<String, dynamic>> currentQuestions;
  late List<Map<String, dynamic>> allQuestions;

  @override
  void initState() {
    startTime = DateTime.now();
    super.initState();

    // Flatten all questions from all categories
    allQuestions = QUESTION_BANK.values.expand((list) => list).toList();

    shuffleQuestions();
  }

  void shuffleQuestions() {
    // Shuffle the list for randomness
    allQuestions.shuffle();

    currentQuestions = allQuestions.take(NUM_QUESTIONS).toList();
  }

  Map<String, dynamic> get currentQuestion =>
      currentQuestions[currentQuestionIndex];

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void nextQuestion() {
    String correctAnswer = currentQuestion['answer'];
    bool isCorrect = false;

    // Check if the selected answer is correct
    if (currentQuestion['type'] == 'text') {
      isCorrect = textController.text.toLowerCase().trim() ==
          correctAnswer.toLowerCase().trim();
    } else {
      isCorrect = selectedAnswer == correctAnswer;
    }

    // Update score if correct
    if (isCorrect) {
      setState(() {
        score++;
      });
    }

    // Mark the question as answered
    setState(() {
      isAnswered = true;
    });

    // Add delay before moving to the next question or finishing the quiz
    Future.delayed(const Duration(seconds: 2), () {
      if (currentQuestionIndex < currentQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          textController.clear();
          isAnswered = false;
        });
      } else {
        // Quiz finished
        Navigator.pushReplacementNamed(
          context,
          '/endquiz',
          arguments: {
            'bot': widget.bot,
            'score': score,
            'total': currentQuestions.length,
            'timeTaken': DateTime.now().difference(startTime),
          },
        );
      }
    });
  }

  Color getOptionColor(String option) {
    if (!isAnswered) {
      return Colors.grey[300]!;
    }

    if (option == selectedAnswer &&
        selectedAnswer != currentQuestion['answer']) {
      return Colors.red;
    }

    if (option == selectedAnswer &&
        selectedAnswer == currentQuestion['answer']) {
      return Colors.green;
    }

    return Colors.grey[300]!;
  }

  Color getTextAnswerColor() {
    if (!isAnswered) {
      return Colors.grey[300]!;
    }

    if (textController.text.trim().toLowerCase() ==
        currentQuestion['answer'].toLowerCase().trim()) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  Widget buildAnswerOptions() {
    String questionType = currentQuestion['type'];

    if (questionType == 'mcq') {
      List<String> options = List<String>.from(currentQuestion['options']);
      return Column(
        children: options
            .map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    selectAnswer(option);
                    nextQuestion();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: getOptionColor(option),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else if (questionType == 'truefalse') {
      return Column(
        children: ['True', 'False']
            .map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    selectAnswer(option);
                    nextQuestion();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: getOptionColor(option),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      );
    } else if (questionType == 'text') {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: getTextAnswerColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: textController,
              enabled: !isAnswered,
              decoration: const InputDecoration(
                hintText: 'Your answer...',
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.isNotEmpty ? value : null;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => nextQuestion(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F3D3D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Icon(
              Icons.send,
              color: Colors.grey[400],
              size: 20,
            ),
          )
        ],
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'MCAT Bots',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar
                  SizedBox(
                    width: 80,
                    height: 80,
                    // decoration: BoxDecoration(
                    //   color: Colors.brown[300],
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.bot.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  const DialogueBox()
                ],
              ),

              const SizedBox(height: 20),

              // Question section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F3D3D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      'Question ${currentQuestionIndex + 1}/${currentQuestions.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentQuestion['question'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Answer options
              Expanded(
                child: SingleChildScrollView(
                  child: buildAnswerOptions(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF3F3D3D),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        onTap: (index) {
          // Handle item taps here
          print("Selected Index: $index");
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_add),
            label: 'Study',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.line_weight),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Review',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stadium),
            label: 'Compete',
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
