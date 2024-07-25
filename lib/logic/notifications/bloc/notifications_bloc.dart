// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:loyalty_system_mobile/data/models/notification_model.dart';
import 'package:loyalty_system_mobile/data/repository/notifications_repo.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsRepository notificationsRepository;
  NotificationsBloc(
    this.notificationsRepository,
  ) : super(NotificationsInitial()) {
    on<NotificationsIntialEvent>(_onNotificationsIntialEvent);
    on<LoadNotificationEvent>(_onLoadNotificationEvent);
  }
  void _onNotificationsIntialEvent(
      NotificationsIntialEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsInitial());
  }

  void _onLoadNotificationEvent(
      LoadNotificationEvent event, Emitter<NotificationsState> emit) async {
    emit(NotificationsLoadingState());
    var response =
        await notificationsRepository.loadNotifications({}, 'get_notify');
    if (response is String) {
      emit(NotificationsFailedState(errorMessage: response));
    } else {
      emit(NotificationsLoaddedState(notificationsList: response));
    }
  }
  
}
