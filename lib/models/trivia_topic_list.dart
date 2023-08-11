class TriviaTopicList {
  TriviaTopicList({required this.triviaTopics});

  factory TriviaTopicList.fromJson(Map<String, dynamic> json) {
    return TriviaTopicList(
      triviaTopics: json['trivia_topics'] != null
          ? (json['trivia_topics'] as List<dynamic>)
              .cast<String>()
              .map(TriviaTopic.fromString)
              .toList()
          : [],
    );
  }

  final List<TriviaTopic> triviaTopics;
}

class TriviaTopic {
  TriviaTopic({required this.topic});

  factory TriviaTopic.fromString(String topic) {
    return TriviaTopic(
      topic: topic,
    );
  }

  final String topic;
}
