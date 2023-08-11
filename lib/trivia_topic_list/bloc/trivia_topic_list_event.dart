part of 'trivia_topic_list_bloc.dart';

@immutable
abstract class TriviaTopicListEvent {}

class TriviaTopicListGetTopics extends TriviaTopicListEvent {
  TriviaTopicListGetTopics();
}
