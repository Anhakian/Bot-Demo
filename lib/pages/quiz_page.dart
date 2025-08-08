import 'package:bot_demo/components/bot_app_bar.dart';
import 'package:bot_demo/components/bottom_nav_bar.dart';
import 'package:bot_demo/components/dialogue_box.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/questions.dart';

class QuizScreen extends StatefulWidget {
  final Bot bot;
  final int playerMcat; // starting MCAT score

  const QuizScreen({
    super.key,
    required this.bot,
    this.playerMcat = 509,
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

  String getDifficultyForScore(int score) {
    if (score < 500) return "beginner";
    if (score < 510) return "novice";
    if (score < 520) return "advanced";
    return "expert";
  }

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();

    String difficulty = getDifficultyForScore(widget.playerMcat);
    currentQuestions =
        List<Map<String, dynamic>>.from(QUESTION_BANK[difficulty]!);
    currentQuestions.shuffle();
    currentQuestions = currentQuestions.take(NUM_QUESTIONS).toList();
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

    if (currentQuestion['type'] == 'text') {
      isCorrect = textController.text.toLowerCase().trim() ==
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

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex < currentQuestions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          textController.clear();
          isAnswered = false;
        });
      } else {
        Navigator.pushReplacementNamed(
          context,
          '/endquiz',
          arguments: {
            'bot': widget.bot,
            'score': score,
            'total': currentQuestions.length,
            'timeTaken': DateTime.now().difference(startTime),
            'playerMcat': widget.playerMcat,
          },
        );
      }
    });
  }

  Color getOptionColor(String option) {
    if (!isAnswered) return Colors.grey[300]!;
    if (option == selectedAnswer &&
        selectedAnswer != currentQuestion['answer']) return Colors.red;
    if (option == selectedAnswer &&
        selectedAnswer == currentQuestion['answer']) return Colors.green;
    return Colors.grey[300]!;
  }

  Color getTextAnswerColor() {
    if (!isAnswered) return Colors.grey[300]!;
    if (textController.text.trim().toLowerCase() ==
        currentQuestion['answer'].toLowerCase().trim()) return Colors.green;
    return Colors.red;
  }

  Widget buildAnswerOptions() {
    String questionType = currentQuestion['type'];

    if (questionType == 'mcq') {
      return Column(
        children: List<String>.from(currentQuestion['options']).map(
          (option) {
            return Padding(
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
                    child: Text(option,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      );
    } else if (questionType == 'truefalse') {
      return Column(
        children: ['True', 'False'].map((option) {
          return Padding(
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
                  child: Text(option,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
              ),
            ),
          );
        }).toList(),
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
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),
          ),
          SizedBox(height: 10.h),
          ElevatedButton(
            onPressed: () => nextQuestion(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F3D3D),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.sp)),
            ),
            child: Icon(Icons.send, color: Colors.grey[400], size: 20.sp),
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
      appBar: const BotAppBar(name: 'MCAT Bots'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 70.w,
                    height: 70.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(widget.bot.image, fit: BoxFit.cover),
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
                      'Question ${currentQuestionIndex + 1}/${currentQuestions.length}',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      currentQuestion['question'],
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
              Expanded(child: SingleChildScrollView(child: buildAnswerOptions())),
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
