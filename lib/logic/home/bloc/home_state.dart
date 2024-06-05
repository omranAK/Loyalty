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
