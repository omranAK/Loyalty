part of 'transfer_bloc.dart';

sealed class TransferState extends Equatable {
  const TransferState();
 
  @override
  List<Object> get props => [];
}

final class TransferInitial extends TransferState {}

final class TransferLoadiingState extends TransferState {}

final class TransferSuccessState extends TransferState {}

final class TransferFaildState extends TransferState {
  final String errorMessage;

  const TransferFaildState(this.errorMessage);
}
