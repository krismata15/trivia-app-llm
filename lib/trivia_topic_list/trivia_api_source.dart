import 'package:dio/dio.dart';
import 'package:llm_trivia/models/trivia_question.dart';
import 'package:llm_trivia/models/trivia_topic_list.dart';

class TriviaApiSource {
  TriviaApiSource({required this.dio});

  final Dio dio;

  Future<List<TriviaTopic>> getTriviaTopics() async {
    const String url = '/trivia-topics';
    try {
      final response = await dio.get<Map<String, dynamic>>(url);

      return TriviaTopicList.fromJson(response.data!['data']).triviaTopics;
    } catch (e, s) {
      rethrow;
    }
  }

  Future<TriviaQuestion> getTriviaQuestion(
      String topic, List<String> previousQuestions) async {
    const String url = '/generate-trivia';
    try {
      final response = await dio.post<Map<String, dynamic>>(
        url,
        data: {
          'trivia_topic': topic,
          'previous_questions': previousQuestions,
        },
      );

      return TriviaQuestion.fromJson(response.data!['data']);
    } catch (e, s) {
      rethrow;
    }
  }
}
