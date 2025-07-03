import 'dart:convert';
import 'package:http/http.dart' as http;

class FlaskService {
  // Replace this with your real ngrok or server URL
  static const String baseUrl = "https://abc123.ngrok.io";

  // Call /start to begin a new session
  Future<Map<String, dynamic>> startGame(String bot, String player) async {
    final response = await http.post(
      Uri.parse('$baseUrl/start'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "bot": bot,
        "player": player,
      }),
    );
    return jsonDecode(response.body);
  }

  // Call /question to get the next question
  Future<Map<String, dynamic>> getQuestion(String sessionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/question'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "session_id": sessionId,
      }),
    );
    return jsonDecode(response.body);
  }

  // Call /end to finish the quiz and send correct count
  Future<Map<String, dynamic>> endGame(String sessionId, int correctCount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/end'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "session_id": sessionId,
        "correct": correctCount, // Send score from Flutter
      }),
    );
    return jsonDecode(response.body);
  }
}