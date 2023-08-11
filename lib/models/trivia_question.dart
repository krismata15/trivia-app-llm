class TriviaQuestion {
  TriviaQuestion({
    this.answer,
    this.difficulty,
    this.options,
    this.question,
  });

  TriviaQuestion.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['trivia_question'];
    answer = data['answer'];
    //difficulty = data['difficulty'];
    options = data['options'] != null
        ? (data['options'] as List).map((e) => e.toString()).toList()
        : [];
    question = data['question'];
  }
  String? answer;
  String? difficulty;
  List<String>? options;
  String? question;
  TriviaQuestion copyWith({
    String? answer,
    String? difficulty,
    List<String>? options,
    String? question,
  }) =>
      TriviaQuestion(
        answer: answer ?? this.answer,
        difficulty: difficulty ?? this.difficulty,
        options: options ?? this.options,
        question: question ?? this.question,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer'] = answer;
    map['difficulty'] = difficulty;
    map['options'] = options;
    map['question'] = question;
    return map;
  }
}
