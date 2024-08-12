part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileloaddedState extends ProfileState {
  final User user;
  const ProfileloaddedState(this.user);
}

final class ProfileLoadingState extends ProfileState {}

final class ProfileFaildState extends ProfileState {
  final String errorMessage;

  const ProfileFaildState(this.errorMessage);
}

final class ProfileUpdateSuccessState extends ProfileState {
  final User user;

  const ProfileUpdateSuccessState({required this.user});
}

final class ProfileUpdateFailedState extends ProfileState {
  final String errorMessage;

  const ProfileUpdateFailedState({required this.errorMessage});
}

final class ProfileUpdateLoadingState extends ProfileState {}

final class ChartLoadedState extends ProfileState {
  final ChartModel chart;

  const ChartLoadedState({required this.chart});
}

final class ChartLoadingState extends ProfileState {}

final class ChartFailedState extends ProfileState {
  final String errorMessage;

  const ChartFailedState({
    required this.errorMessage,
  });
}
