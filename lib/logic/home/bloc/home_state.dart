part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class LogoutSuccessState extends HomeState {}

final class LogoutFaildState extends HomeState {}

// ignore: must_be_immutable
final class DataLoadedState extends HomeState {
  var points;
  final List<VoucherModel> vouchers;
  final String email;

  DataLoadedState(this.points, this.vouchers, this.email);
}

final class DataLoadingState extends HomeState {}

final class DataFaildState extends HomeState {
  final String errorMessage;

  const DataFaildState(this.errorMessage);
}

final class ConsumingSuccessState extends HomeState {
  final String otp;

  const ConsumingSuccessState({required this.otp});
}

final class ConsumingFailedState extends HomeState {
  final String errorMessage;

  const ConsumingFailedState({required this.errorMessage});
}

final class ConsumingLoaadingState extends HomeState {}

final class GenerateOtpSuccessState extends HomeState {
  final String otp;

  const GenerateOtpSuccessState({required this.otp});
}

final class GenerateOtpFailedState extends HomeState {
  final String errorMessage;

  const GenerateOtpFailedState({required this.errorMessage});
}

final class GenerateOtpLoadingState extends HomeState {}
