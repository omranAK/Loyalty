import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/user_model.dart';
import 'package:loyalty_system_mobile/data/repository/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitialState()) {
    on<LogginButtonPressedEvent>(_onLogginButtonPressedEvent);
    on<SignupButtonPressedEvent>(_onSignupButtonPressedEvent);
  }

  void _onLogginButtonPressedEvent(
      LogginButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    print("Loading");
    var response = await authRepository.login(
      event.email,
      event.password,
    );
    if (response is String) {
      emit(AuthFailedState(response));
    } else {
      emit(AuthSuccessState(response));
    }
  }

  void _onSignupButtonPressedEvent(
      SignupButtonPressedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    print('Loading');
    var response = await authRepository.signup(
      event.name,
      event.email,
      event.password,
      event.phonenumber,
    );
    if (response is String) {
      emit(AuthFailedState(response));
    } else {
      emit(AuthSuccessState(response));
    }
  }
}
