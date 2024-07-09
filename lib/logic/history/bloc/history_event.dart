part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class HistoryInitialEvent extends HistoryEvent {}

final class LoadHistoryEvent extends HistoryEvent {}
