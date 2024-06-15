import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApi {
  GeminiApi({required String type})
      : _model = GenerativeModel(
          model: type,
          apiKey: dotenv.get("GEMINI_KEY"),
        );

  final GenerativeModel _model;

  Future<String?> generateContent(String prompt) async {
    final response = await _model.generateContent([
      Content.text(prompt),
    ]);

    return response.text;
  }
}