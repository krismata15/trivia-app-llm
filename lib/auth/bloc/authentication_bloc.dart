import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:llm_trivia/auth/firebase_auth_service.dart';
import 'package:llm_trivia/models/user_app.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticateAnonymously>(_authenticateAnonymously);
    //on<AuthenticationInitialCheck>(_checkIfUserAlreadyAuthenticated);
  }

  FirebaseAuthService authService = FirebaseAuthService();

  /*Future<void> _checkIfUserAlreadyAuthenticated(
    AuthenticationInitialCheck event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final UserApp userApp = await authService.getCurrentUser();

      emit(AuthenticationAuthenticated(user: userApp));
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }*/

  Future<void> _authenticateAnonymously(
    AuthenticateAnonymously event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      emit(AuthenticationInProgress());

      await authService.signInAnonymously(event.username);

      emit(AuthenticationAuthenticated());
    } catch (e) {
      emit(AuthenticationFailure());
    }
  }
}
