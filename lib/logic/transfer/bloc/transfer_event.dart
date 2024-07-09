part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();

  @override
  List<Object> get props => [];
}

final class TransferIntialEvent extends TransferEvent {}


final class ProccedButtonPressedEvent extends TransferEvent {
  final String email;
  final double ammount;

  const ProccedButtonPressedEvent({
    required this.email,
    required this.ammount,
  });
  @override
  List<Object> get props => [email, ammount];
}
