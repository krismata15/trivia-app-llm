import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:llm_trivia/auth/bloc/authentication_bloc.dart';
import 'package:llm_trivia/auth/login_anonymously_page.dart';
import 'package:llm_trivia/dio_service.dart';
import 'package:llm_trivia/firebase_options.dart';
import 'package:llm_trivia/home_screen.dart';
import 'package:llm_trivia/trivia_questions/trivia_questions_page.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioService().init(
    Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8080/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers':
              'Origin, X-Requested-With, Content-Type, Accept'
        },
      ),
    )..interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
        ),
      ),
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
        ),
        routerConfig: _router,
      ),
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser == null) {
          return '/login';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: 'trivia/:trivia_topic',
          builder: (context, state) => TriviaQuestionsPage(
            triviaTopic: state.pathParameters['trivia_topic']!,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginAnonymouslyPage(),
      redirect: (context, state) {
        if (FirebaseAuth.instance.currentUser != null) {
          return '/';
        }
        return null;
      },
    ),
  ],
);
