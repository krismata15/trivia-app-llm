import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_trivia/dio_service.dart';
import 'package:llm_trivia/models/trivia_question.dart';
import 'package:llm_trivia/trivia_topic_list/trivia_api_source.dart';

part 'trivia_questions_event.dart';
part 'trivia_questions_state.dart';

class TriviaQuestionsBloc
    extends Bloc<TriviaQuestionsEvent, TriviaQuestionsState> {
  TriviaQuestionsBloc()
      : super(
          const TriviaQuestionsInitial(
            previousQuestions: [],
            questionNumber: 0,
            triviaTopic: '',
          ),
        ) {
    on<TriviaQuestionsGetQuestion>(_getTriviaQuestion);
  }

  TriviaApiSource triviaApiSource = TriviaApiSource(dio: DioService.dio);

  Future<void> _getTriviaQuestion(
    TriviaQuestionsGetQuestion event,
    Emitter<TriviaQuestionsState> emit,
  ) async {
    emit(
      TriviaQuestionsLoading(
        previousQuestions: state.previousQuestions,
        questionNumber: state.questionNumber,
        triviaTopic: event.triviaTopic,
        triviaQuestion: state.triviaQuestion,
      ),
    );
    try {
      final TriviaQuestion triviaQuestion =
          await triviaApiSource.getTriviaQuestion(
        event.triviaTopic,
        state.previousQuestions,
      );

      final List<String> previousQuestions = state.previousQuestions
          .map((e) => e)
          .toList()
        ..add(triviaQuestion.question!);

      emit(
        TriviaQuestionsLoaded(
          previousQuestions: previousQuestions,
          questionNumber: state.questionNumber + 1,
          triviaTopic: event.triviaTopic,
          triviaQuestion: triviaQuestion,
        ),
      );
    } catch (e) {
      emit(
        TriviaQuestionsError(
          previousQuestions: state.previousQuestions,
          questionNumber: state.questionNumber,
          triviaTopic: event.triviaTopic,
          triviaQuestion: state.triviaQuestion,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
