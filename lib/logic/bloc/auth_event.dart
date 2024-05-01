part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthIntialEvent extends AuthEvent {}

class LogginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;
  const LogginButtonPressedEvent(this.email, this.password);
}

class SignupButtonPressedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phonenumber;

  const SignupButtonPressedEvent(
    this.name,
    this.email,
    this.password,
    this.phonenumber,
  );
}
