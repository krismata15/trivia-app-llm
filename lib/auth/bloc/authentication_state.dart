part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  AuthenticationAuthenticated();
}

class AuthenticationFailure extends AuthenticationState {}
