part of 'charity_bloc.dart';

sealed class CharityEvent extends Equatable {
  const CharityEvent();

  @override
  List<Object> get props => [];
}

final class CharityIntialEvent extends CharityEvent {}

final class LoadCharityEvent extends CharityEvent {}

final class DonateSpicialPointsEvent extends CharityEvent {
  final String ammount;
  final int charityID;
  const DonateSpicialPointsEvent(this.charityID, {required this.ammount});
  @override
  List<Object> get props => [ammount, charityID];
}
