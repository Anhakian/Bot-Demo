import 'package:bot_demo/main.dart';
import 'package:bot_demo/models/bot.dart';
import 'package:bot_demo/models/end_game_result.dart';
import 'package:bot_demo/pages/bot_detail_page.dart';
import 'package:bot_demo/pages/quiz_page.dart';
import 'package:bot_demo/pages/end_quiz_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String myAppRoute = '/';
  static const String botDetailRoute = '/bot';
  static const String botQuizRoute = '/botQuiz';
  static const String endQuizRoute = '/endquiz';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case myAppRoute:
        return MaterialPageRoute(builder: (_) => const MyApp());

      case botDetailRoute:
        final bot = settings.arguments as Bot;
        return MaterialPageRoute(builder: (_) => BotDetailPage(bot: bot));

      case botQuizRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => QuizScreen(
            bot: args['bot'],
            sessionId: args['sessionId'],
            startComment: args['startComment'],
          ),
        );

      case endQuizRoute:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Missing quiz data')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => EndQuizPage(
            sessionId: args['sessionId'],
            bot: args['bot'],
            total: args['total'],
            timeTaken: args['timeTaken'],
            endGameResult: args['endGameResult'] as EndGameResult,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('404 - Page not found')),
          ),
        );
    }
  }
}
