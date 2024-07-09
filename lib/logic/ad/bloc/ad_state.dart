part of 'ad_bloc.dart';

sealed class AdState extends Equatable {
  const AdState();

  @override
  List<Object> get props => [];
}

final class AdInitial extends AdState {}

final class AdLoaddedState extends AdState {
  final Ad ad;

  const AdLoaddedState({required this.ad});
}

final class AdFaildState extends AdState {
  final String errorMessage;

  const AdFaildState({required this.errorMessage});
}

final class AdLoadingState extends AdState {}

final class AdFinishedState extends AdState {}
