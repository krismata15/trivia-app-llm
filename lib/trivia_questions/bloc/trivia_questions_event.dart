part of 'trivia_questions_bloc.dart';

@immutable
abstract class TriviaQuestionsEvent {}

class TriviaQuestionsGetQuestion extends TriviaQuestionsEvent {
  TriviaQuestionsGetQuestion({required this.triviaTopic});

  final String triviaTopic;
}
