import 'package:bloc/bloc.dart';
import 'package:llm_trivia/dio_service.dart';
import 'package:llm_trivia/models/trivia_topic_list.dart';
import 'package:llm_trivia/trivia_topic_list/trivia_api_source.dart';
import 'package:meta/meta.dart';

part 'trivia_topic_list_event.dart';
part 'trivia_topic_list_state.dart';

class TriviaTopicListBloc
    extends Bloc<TriviaTopicListEvent, TriviaTopicListState> {
  TriviaTopicListBloc() : super(TriviaTopicListInitial()) {
    on<TriviaTopicListGetTopics>(_getTriviaTopics);
  }

  TriviaApiSource apiSource = TriviaApiSource(dio: DioService.dio);

  Future<void> _getTriviaTopics(TriviaTopicListGetTopics event,
      Emitter<TriviaTopicListState> emit) async {
    emit(TriviaTopicListLoading());
    try {
      final List<TriviaTopic> topics = await apiSource.getTriviaTopics();

      emit(TriviaTopicListLoaded(topics: topics));
    } catch (e) {
      emit(TriviaTopicListError(message: e.toString()));
    }
  }
}
