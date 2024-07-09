part of 'ad_bloc.dart';

sealed class AdEvent extends Equatable {
  const AdEvent();

  @override
  List<Object> get props => [];
}

final class AdInitialEvent extends AdEvent {}

final class LoadAdEvenet extends AdEvent {}

final class CompletedWatchAdEvent extends AdEvent {
  final int adId;

  const CompletedWatchAdEvent({required this.adId});
}
