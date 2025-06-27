import 'dart:convert';
import 'package:http/http.dart' as http;

class FlaskService {
  static const String baseUrl = "https://abc123.ngrok.io"; // Replace with ngrok URL

  Future<Map<String, dynamic>> startGame(String bot, String player) async {
    final response = await http.post(
      Uri.parse('$baseUrl/start'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"bot": bot, "player": player}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getQuestion(String sessionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/question'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"session_id": sessionId}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> endGame(String sessionId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/end'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"session_id": sessionId}),
    );
    return jsonDecode(response.body);
  }
}
