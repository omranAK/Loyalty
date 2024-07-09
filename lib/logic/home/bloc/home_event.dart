part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeInitialEvent extends HomeEvent {}

final class LogoutButtonPressedEvent extends HomeEvent {}

final class GetHomeDateEvent extends HomeEvent {}

final class ConsumeVoucherEvent extends HomeEvent {
  final int voucherID;

  const ConsumeVoucherEvent({required this.voucherID});
}

final class GenerateOtpEvent extends HomeEvent {}
