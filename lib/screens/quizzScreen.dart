import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quizz_ai/widget/quizz.dart';
import 'package:shimmer/shimmer.dart';
import '../core/dataSource/questionsDataSource.dart';
import '../core/gemini_api_call.dart';
import '../widget/shimmer.dart';
import 'resultScreen.dart';

class QuizzScreen extends StatefulWidget {
  final String subject;
  final String level;
  final int numberOfQuestions;
  final String language;

  const QuizzScreen(
      {super.key,
      required this.subject,
      required this.level,
      required this.numberOfQuestions,
      required this.language});

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  // List<Map<String, dynamic>> questions = [];

  bool loaded = false;
  @override
  initState() {
    super.initState();
    print('asking');

    askQuestions();
    print('data');
  }

  askQuestions() async {
    QuestionsDataSource questionsDataSource =
        QuestionsDataSource(client: GeminiApi(type: "gemini-1.5-flash"));
    String? response = await questionsDataSource.askQuestions(widget.subject,
        widget.level, widget.language, widget.numberOfQuestions);
    print(response);
    final data = json.decode(response ?? "");

    List<Map<String, dynamic>> questions =
        (data['questions'] as List).map((question) {
      return {
        'questionText': question['label'],
        'answers': question['answers'],
      };
    }).toList();

    return questions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Jouez',
          style: TextStyle(color: Colors.white),
        ),
        // backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
          future: askQuestions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerList();
            } else if (snapshot.hasError) {
              return Text('error');
            } else {
              return QuizzWidget(data: snapshot.data);
            }
          }),
    );
  }
}
