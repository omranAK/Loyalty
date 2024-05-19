part of 'charity_bloc.dart';

sealed class CharityEvent extends Equatable {
  const CharityEvent();

  @override
  List<Object> get props => [];
}
final class LoadCharityEvent extends CharityEvent {}