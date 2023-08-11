import 'package:flutter/material.dart';
import 'package:llm_trivia/header.dart';
import 'package:llm_trivia/trivia_topic_list/trivia_topic_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(),
          Expanded(
            child: TriviaTopicListPage(),
          ),
        ],
      ),
    );
  }
}
