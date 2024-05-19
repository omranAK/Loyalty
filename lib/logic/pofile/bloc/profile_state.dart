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
