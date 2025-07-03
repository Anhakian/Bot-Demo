import 'package:bot_demo/components/bot_app_bar.dart';
import 'package:bot_demo/components/bottom_nav_bar.dart';
import 'package:bot_demo/components/dialogue_box.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../lib/services/flask_service.dart';

class QuizScreen extends StatefulWidget {
  final Bot bot;
  final String sessionId;

  const QuizScreen({
    super.key,
    required this.bot,
    required this.sessionId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const int NUM_QUESTIONS = 5;

  int currentQuestionIndex = 0;
  String? selectedAnswer;
  TextEditingController textController = TextEditingController();
  int score = 0;
  bool isAnswered = false;

  late DateTime startTime;
  final FlaskService _flaskService = FlaskService();

  // This holds the current question from the API
  Map<String, dynamic>? currentQuestion;

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    fetchQuestionFromApi(); // Load the first question
  }

  // This method fetches a question from the Flask backend
  Future<void> fetchQuestionFromApi() async {
    try {
      final response = await _flaskService.getQuestion(widget.sessionId);
      print("Fetched question: ${response['question']}");

      setState(() {
        currentQuestion = {
          "question": response["question"],
          "options": response["options"],
          "type": response["type"],
          "answer": "placeholder" // Use real answer later when API supports it
        };
      });
    } catch (e) {
      print("Error fetching question: $e");
    }
  }

  // Called when the user selects an answer
  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  // Handles moving to the next question or ending the quiz
  void nextQuestion() async {
    final correctAnswer = currentQuestion?["answer"] ?? "";
    bool isCorrect = false;

    if (currentQuestion?["type"] == "text") {
      isCorrect = textController.text.trim().toLowerCase() ==
          correctAnswer.toLowerCase().trim();
    } else {
      isCorrect = selectedAnswer == correctAnswer;
    }

    if (isCorrect) {
      setState(() {
        score++;
      });
    }

    setState(() {
      isAnswered = true;
    });

    // Delay to show feedback before moving on
    await Future.delayed(const Duration(seconds: 2));

    currentQuestionIndex++;
    if (currentQuestionIndex < NUM_QUESTIONS) {
      setState(() {
        selectedAnswer = null;
        textController.clear();
        isAnswered = false;
      });
      await fetchQuestionFromApi();
    } else {
      // Call the /end API and send the score
      await _flaskService.endGame(widget.sessionId, score);

      // Navigate to the end quiz screen
      Navigator.pushReplacementNamed(
        context,
        '/endquiz',
        arguments: {
          'bot': widget.bot,
          'score': score,
          'total': NUM_QUESTIONS,
          'timeTaken': DateTime.now().difference(startTime),
        },
      );
    }
  }

  // Sets the color of MCQ options based on correctness
  Color getOptionColor(String option) {
    if (!isAnswered) return Colors.grey[300]!;
    if (option == selectedAnswer &&
        selectedAnswer != currentQuestion?['answer']) return Colors.red;
    if (option == selectedAnswer &&
        selectedAnswer == currentQuestion?['answer']) return Colors.green;
    return Colors.grey[300]!;
  }

  // Sets color of the text answer box
  Color getTextAnswerColor() {
    if (!isAnswered) return Colors.grey[300]!;
    return (textController.text.trim().toLowerCase() ==
        currentQuestion?['answer'].toLowerCase().trim())
        ? Colors.green
        : Colors.red;
  }

  // Builds the answer options (MCQ, True/False, or Text)
  Widget buildAnswerOptions() {
    if (currentQuestion == null) {
      return const Center(child: CircularProgressIndicator());
    }

    String questionType = currentQuestion!['type'];

    if (questionType == 'mcq') {
      List<String> options = List<String>.from(currentQuestion!['options']);
      return Column(
        children: options
            .map(
              (option) => Padding(
            padding: EdgeInsets.only(bottom: 16.sp),
            child: GestureDetector(
              onTap: () {
                selectAnswer(option);
                nextQuestion();
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: getOptionColor(option),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16.sp,
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
            padding: EdgeInsets.only(bottom: 16.sp),
            child: GestureDetector(
              onTap: () {
                selectAnswer(option);
                nextQuestion();
              },
              child: Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: getOptionColor(option),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Center(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 16.sp,
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
            padding: EdgeInsets.all(16.sp),
            height: 60.h,
            decoration: BoxDecoration(
              color: getTextAnswerColor(),
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: TextField(
              controller: textController,
              enabled: !isAnswered,
              decoration: const InputDecoration(
                hintText: 'Your answer...',
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  selectedAnswer = value.isNotEmpty ? value : null;
                });
              },
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () => nextQuestion(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F3D3D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.sp),
              ),
            ),
            child: Icon(
              Icons.send,
              color: Colors.grey[400],
              size: 20.sp,
            ),
          )
        ],
      );
    }

    return const Text("Unsupported question type");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: const BotAppBar(name: 'MCAT Bots'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: currentQuestion == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 70.w,
                    height: 70.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        widget.bot.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 40.sp,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16.sp),
                  const DialogueBox(),
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color: const Color(0xFF3F3D3D),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Column(
                  children: [
                    Text(
                      'Question ${currentQuestionIndex + 1}/$NUM_QUESTIONS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      currentQuestion!['question'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  child: buildAnswerOptions(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
