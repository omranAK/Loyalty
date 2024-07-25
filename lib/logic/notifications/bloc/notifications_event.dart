part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

final class NotificationsIntialEvent extends NotificationsEvent {}

final class LoadNotificationEvent extends NotificationsEvent {}

final class ValidateDeviceTokenEvent extends NotificationsEvent {
  final String deviceToken;

  const ValidateDeviceTokenEvent({required this.deviceToken});
}
