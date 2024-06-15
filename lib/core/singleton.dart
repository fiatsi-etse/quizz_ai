import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiSingleton {
  static final GeminiSingleton _singleton = GeminiSingleton._internal();

  late Gemini _geminiInstance;

  factory GeminiSingleton() {
    return _singleton;
  }

  GeminiSingleton._internal() {
    // Initialisez votre instance Gemini ici

    print('init gemini');
    _geminiInstance = Gemini(GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: ""));
  }

  Gemini get geminiInstance => _geminiInstance;
}

class Gemini {
  final model;

  Gemini(this.model);
}
