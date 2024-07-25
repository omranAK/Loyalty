// ignore_for_file: prefer_typing_uninitialized_variables

part of 'charity_bloc.dart';

sealed class CharityState extends Equatable {
  const CharityState();

  @override
  List<Object> get props => [];
}

final class CharityInitial extends CharityState {}

final class CharityLoadingState extends CharityState {}

// ignore: must_be_immutable
final class CharityLoaddedState extends CharityState {
  final List<CharityModel> charities;
  var spicialPoints;

  CharityLoaddedState(this.charities, this.spicialPoints);
}

final class CharityFailedState extends CharityState {
  final String errorMessage;

  const CharityFailedState(this.errorMessage);
}

final class DonateDoneState extends CharityState {}

final class DonateFailedState extends CharityState {
  final String errorMessage;

  const DonateFailedState({required this.errorMessage});
}

final class DonateLoadingState extends CharityState {}
