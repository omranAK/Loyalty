part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthIntialEvent extends AuthEvent {}

final class LoginButtonPressedEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginButtonPressedEvent(
    this.email,
    this.password,
  );
}

final class SignUpButtonPressedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  const SignUpButtonPressedEvent(
    this.name,
    this.email,
    this.password,
    this.phone,
  );
}

final class ConfirmOtpButtonPressedEvent extends AuthEvent {
  final String otp;

  const ConfirmOtpButtonPressedEvent({required this.otp});
}

final class ResendOtpButtonPressedEvent extends AuthEvent {}

final class ActiveNowButtonPressedEvent extends AuthEvent {}

final class ChangeEmailEvent extends AuthEvent {
  final String newEmail;

  const ChangeEmailEvent({required this.newEmail});
}
