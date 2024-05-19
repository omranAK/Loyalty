part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoaddedState extends HistoryState {
  final List<PointHistoryModel> history_list;

  const HistoryLoaddedState({required this.history_list});
}

final class HistoryFaildState extends HistoryState {
  final String errorMessage;

  const HistoryFaildState({required this.errorMessage});
}

final class HistoryLoadingState extends HistoryState {}
