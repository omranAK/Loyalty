part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;

  const AuthSuccessState(this.user);
}

class AuthFailedState extends AuthState {
  final String errorMessage;

  const AuthFailedState(this.errorMessage);
}
