part of 'trivia_questions_bloc.dart';

@immutable
abstract class TriviaQuestionsState {
  const TriviaQuestionsState({
    required this.triviaTopic,
    required this.questionNumber,
    required this.previousQuestions,
    this.triviaQuestion,
  });

  final TriviaQuestion? triviaQuestion;
  final int questionNumber;
  final String triviaTopic;
  final List<String> previousQuestions;
}

class TriviaQuestionsInitial extends TriviaQuestionsState {
  const TriviaQuestionsInitial({
    required super.triviaTopic,
    required super.questionNumber,
    required super.previousQuestions,
    super.triviaQuestion,
  });
}

class TriviaQuestionsLoading extends TriviaQuestionsState {
  const TriviaQuestionsLoading({
    required super.triviaTopic,
    required super.questionNumber,
    required super.previousQuestions,
    super.triviaQuestion,
  });
}

class TriviaQuestionsLoaded extends TriviaQuestionsState {
  const TriviaQuestionsLoaded({
    required super.triviaTopic,
    required super.questionNumber,
    required super.previousQuestions,
    required this.triviaQuestion,
  }) : super(
          triviaQuestion: triviaQuestion,
        );

  @override
  final TriviaQuestion triviaQuestion;
}

class TriviaQuestionsError extends TriviaQuestionsState {
  const TriviaQuestionsError({
    required super.triviaTopic,
    required super.questionNumber,
    required super.previousQuestions,
    required this.errorMessage,
    super.triviaQuestion,
  });

  final String errorMessage;
}
