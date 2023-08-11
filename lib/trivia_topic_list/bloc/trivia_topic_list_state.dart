part of 'trivia_topic_list_bloc.dart';

@immutable
abstract class TriviaTopicListState {}

class TriviaTopicListInitial extends TriviaTopicListState {}

class TriviaTopicListLoading extends TriviaTopicListState {}

class TriviaTopicListLoaded extends TriviaTopicListState {
  TriviaTopicListLoaded({required this.topics});

  final List<TriviaTopic> topics;
}

class TriviaTopicListError extends TriviaTopicListState {
  TriviaTopicListError({required this.message});

  final String message;
}
