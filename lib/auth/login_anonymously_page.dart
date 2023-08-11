import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:llm_trivia/auth/bloc/authentication_bloc.dart';
import 'package:llm_trivia/utils/basic_styles.dart';

class LoginAnonymouslyPage extends StatefulWidget {
  const LoginAnonymouslyPage({super.key, this.guardedRoute});

  final String? guardedRoute;

  @override
  State<LoginAnonymouslyPage> createState() => _LoginAnonymouslyPageState();
}

class _LoginAnonymouslyPageState extends State<LoginAnonymouslyPage> {
  bool isLoading = false;

  String? username;

  @override
  Widget build(BuildContext context) {
    final bool validUsername = username != null && username!.isNotEmpty;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationInProgress) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }

        if (state is AuthenticationAuthenticated) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: BasicStyles.horizontalPadding,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose your display name',
                style: BasicStyles.titleStyle,
              ),
              const SizedBox(
                height: BasicStyles.standardSeparationVertical * 2.5,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(
                height: BasicStyles.standardSeparationVertical * 2,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: validUsername
                      ? () {
                          context.read<AuthenticationBloc>().add(
                                AuthenticateAnonymously(username: username!),
                              );
                        }
                      : null,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
