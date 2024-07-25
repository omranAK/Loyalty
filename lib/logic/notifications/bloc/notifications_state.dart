part of 'notifications_bloc.dart';

sealed class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoaddedState extends NotificationsState {
  final List<NotificationModel> notificationsList;

  const NotificationsLoaddedState({required this.notificationsList});
}

final class NotificationsFailedState extends NotificationsState {
  final String errorMessage;

  const NotificationsFailedState({required this.errorMessage});
}

final class NotificationsLoadingState extends NotificationsState {}

final class ValidateDeviceTokenSuccessState extends NotificationsState {}

final class ValidateDeviceTokenFailedState extends NotificationsState {}
