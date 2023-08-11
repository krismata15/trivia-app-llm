import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_trivia/header.dart';
import 'package:llm_trivia/models/trivia_question.dart';
import 'package:llm_trivia/trivia_questions/bloc/trivia_questions_bloc.dart';

class TriviaQuestionsPage extends StatefulWidget {
  const TriviaQuestionsPage({required this.triviaTopic, super.key});

  final String triviaTopic;

  @override
  State<TriviaQuestionsPage> createState() => _TriviaQuestionsPageState();
}

class _TriviaQuestionsPageState extends State<TriviaQuestionsPage> {
  String? _selectedAnswer;
  String? rightAnswer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TriviaQuestionsBloc()
        ..add(TriviaQuestionsGetQuestion(triviaTopic: widget.triviaTopic)),
      child: Scaffold(
        body: Column(
          children: [
            const Header(),
            Expanded(
              child: BlocListener<TriviaQuestionsBloc, TriviaQuestionsState>(
                listener: (context, state) {
                  if (state is TriviaQuestionsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Try in another time, maybe you already reached the limit of questions'),
                      ),
                    );
                  }

                  if (state is TriviaQuestionsLoaded) {
                    setState(() {
                      _selectedAnswer = null;
                    });
                  }
                },
                child: BlocBuilder<TriviaQuestionsBloc, TriviaQuestionsState>(
                  builder: (context, state) {
                    final TriviaQuestion? triviaQuestion = state.triviaQuestion;

                    if (state is TriviaQuestionsLoading) {
                      if (state.questionNumber == 0) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }

                    if (triviaQuestion == null) {
                      return const Center(
                        child: Text('No trivia questions found'),
                      );
                    }

                    return Center(
                      child: Container(
                        constraints: const BoxConstraints(
                          maxWidth: 600,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              'Trivia Questions',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              state.triviaQuestion!.question!.trim(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Flexible(
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 20,
                                ),
                                primary: true,
                                itemCount:
                                    state.triviaQuestion!.options!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          _selectedAnswer = state
                                              .triviaQuestion!.options!
                                              .elementAt(index);
                                        });
                                      },
                                      leading: AbsorbPointer(
                                        child: Radio(
                                          value: state.triviaQuestion!.options!
                                              .elementAt(index),
                                          onChanged: (value) {},
                                          groupValue: _selectedAnswer,
                                        ),
                                      ),
                                      title: Text(
                                        state.triviaQuestion!.options!
                                            .elementAt(index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(200, 50),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: _selectedAnswer != null &&
                                      state is TriviaQuestionsLoaded
                                  ? () {
                                      if (_selectedAnswer ==
                                          triviaQuestion.answer) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: const Duration(
                                              milliseconds: 2000,
                                            ),
                                            content: const Text(
                                              'Correct!',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor:
                                                Colors.greenAccent.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            duration: const Duration(
                                              milliseconds: 2000,
                                            ),
                                            content: const Text(
                                              'Incorrect!',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor:
                                                Colors.redAccent.withOpacity(
                                              0.5,
                                            ),
                                          ),
                                        );
                                      }
                                      context.read<TriviaQuestionsBloc>().add(
                                            TriviaQuestionsGetQuestion(
                                              triviaTopic: widget.triviaTopic,
                                            ),
                                          );
                                    }
                                  : null,
                              child: state is TriviaQuestionsLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Confirm'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
