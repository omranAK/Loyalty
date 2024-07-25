part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileInitialEvent extends ProfileEvent {}

final class GetProfileDataEvent extends ProfileEvent {}

// ignore: must_be_immutable
final class UpdateUserDataEvent extends ProfileEvent {
  String? name;
  String? phone;
  final String oldPassword;
  String? newPassword;
  String? location;
  String? description;

  UpdateUserDataEvent(
      {required this.oldPassword,
      this.phone,
      this.description,
      this.location,
      this.name,
      this.newPassword});
}
