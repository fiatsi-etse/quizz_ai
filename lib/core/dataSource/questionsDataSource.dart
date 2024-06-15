import 'package:google_generative_ai/google_generative_ai.dart';

import '../gemini_api_call.dart';


class QuestionsDataSource {
  const QuestionsDataSource({
    required GeminiApi client,
  }) : _client = client;

  final GeminiApi _client;

  Future<String?> askQuestions(String subject, String level, String language, int numberOfQuestions) async {
    final prompt = '''
    You're a system that helps people prepare for job quiz games. Create another best list of questions that could help a person on $subject in $language.
    Give me $numberOfQuestions MCQs questions (4 options maximum per question but one option must be correct per questions, all in one block and no image in the questions) for $level level. 
    Provide your answer in the following JSON format: {"questions": [{"label":"", "answers":[{"label":"", "isCorrect":false},{"label":"", "isCorrect":true}]}]}. Generate all in one block
    Do not return the result as Markdown and do not include the format type (json) in your anwer.
    
    ''';

    try {
      final response = await _client.generateContent(prompt);
  
      if (response == null) {
        print('null response');
        //TODO: handle
      }
      return response;      
    } on GenerativeAIException {
      //TODO: handle
    } catch (e) {
      //TODO: handle
    }
    return null;
  }
}