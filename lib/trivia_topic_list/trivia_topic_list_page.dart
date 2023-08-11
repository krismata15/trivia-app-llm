import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:llm_trivia/trivia_topic_list/bloc/trivia_topic_list_bloc.dart';

class TriviaTopicListPage extends StatelessWidget {
  const TriviaTopicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TriviaTopicListBloc()..add(TriviaTopicListGetTopics()),
      child: Scaffold(
        body: BlocListener<TriviaTopicListBloc, TriviaTopicListState>(
          listener: (context, state) {
            if (state is TriviaTopicListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<TriviaTopicListBloc, TriviaTopicListState>(
            builder: (context, state) {
              if (state is TriviaTopicListLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is TriviaTopicListLoaded) {
                return Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Trivia Topics',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                            primary: true,
                            itemCount: state.topics.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    final List<String> topicSplit =
                                        state.topics[index].topic.split(' ')
                                          ..removeLast();

                                    final String topicClean =
                                        topicSplit.join(' ');

                                    context.go('/trivia/$topicClean');
                                  },
                                  title: Text(state.topics[index].topic),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
