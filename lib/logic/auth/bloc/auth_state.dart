part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthFaildState extends AuthState {
  final String errorMessage;
  const AuthFaildState(this.errorMessage);
}

final class AuthLoadingState extends AuthState {}

final class LoginSuccessState extends AuthState {
  final UserSetting user;

  const LoginSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

final class SignUpSuccessState extends AuthState {
  final UserSetting user;

  const SignUpSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

final class OtpSuccessState extends AuthState {}

final class OtpFaildState extends AuthState {}

final class OtpLoadingState extends AuthState {}
