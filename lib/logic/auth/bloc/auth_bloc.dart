// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/user_setting_model.dart';
import 'package:loyalty_system_mobile/data/repository/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitialState()) {
    on<AuthIntialEvent>(_onAuthIntialEvent);
    on<LoginButtonPressedEvent>(_onLoginButtonPressedEvent);
    on<SignUpButtonPressedEvent>(_onSignUpButtonPressedEvent);
    on<ConfirmOtpButtonPressedEvent>(_onConfirmOtpButtonPressedEvent);
    on<ResendOtpButtonPressedEvent>(_onResendOtpButtonPressedEvent);
    on<ChangeEmailEvent>(_onChangeEmailEvent);
  }

  void _onAuthIntialEvent(
      AuthIntialEvent event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
  }

  void _onLoginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var response = await _authRepository.login(
        {'email': event.email, 'password': event.password}, 'auth/login');
    if (response is String) {
      emit(AuthFaildState(response));
    } else {
      emit(LoginSuccessState(response));
    }
  }

  void _onSignUpButtonPressedEvent(
      SignUpButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    var response = await _authRepository.signup({
      'name': event.name,
      'email': event.email,
      'password': event.password,
      'phone': event.phone,
      'password_confirmation': event.password,
    }, 'auth/sign-up/client');
    if (response is String) {
      emit(AuthFaildState(response));
    } else {
      var response1 = await _authRepository.sendOtp();
      if (response1 == 'success') {
        emit(SignUpSuccessState(response));
      } else {
        emit(
          const AuthFaildState('Faild to Send otp, please try again'),
        );
      }
    }
  }

  void _onConfirmOtpButtonPressedEvent(
      ConfirmOtpButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(OtpLoadingState());
    var response = await _authRepository
        .confirmEmail({'otp_from_user': event.otp}, 'email_verification');
    if (response == 'success') {
      emit(OtpSuccessState());
    } else {
      emit(OtpFaildState());
    }
  }

  void _onResendOtpButtonPressedEvent(
      ResendOtpButtonPressedEvent event, Emitter<AuthState> emit) async {
    await _authRepository.sendOtp();
  }

  void _onChangeEmailEvent(
      ChangeEmailEvent event, Emitter<AuthState> emit) async {
    emit(ChangeEmailLoadingState());
    var response = await _authRepository
        .updateEmail({'email': event.newEmail}, 'update_email');
    if (response == 'success') {
      var response1 = await _authRepository.sendOtp();
      if (response1 == 'success') {
        emit(ChangeEmailSuccessState());
      } else {
        emit(const ChangeEmailFaildState(errorMessage: 'Failed to change'));
      }
    } else {
      emit(const ChangeEmailFaildState(errorMessage: 'Failed to change'));
    }
  }
}
