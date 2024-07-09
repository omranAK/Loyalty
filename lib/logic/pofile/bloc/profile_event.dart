part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileInitialEvent extends ProfileEvent {}

final class GetProfileDataEvent extends ProfileEvent {}

final class UpdateUserDataEvent extends ProfileEvent {
  final User user;

  const UpdateUserDataEvent({required this.user});
}
