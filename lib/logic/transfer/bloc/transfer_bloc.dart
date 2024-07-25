// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/repository/transfer_repo.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferRepository transferRepository;
  TransferBloc(this.transferRepository) : super(TransferInitial()) {
    on<TransferIntialEvent>(_onTransferIntialEvent);
    on<ProccedButtonPressedEvent>(_onProccedButtonPressedEvent);
  }
  void _onTransferIntialEvent(
      TransferIntialEvent event, Emitter<TransferState> emit) async {
    emit(TransferInitial());
  }

  void _onProccedButtonPressedEvent(
      ProccedButtonPressedEvent event, Emitter<TransferState> emit) async {
    emit(TransferLoadiingState());
    String response = await transferRepository.makeTranfer(
        {'points': event.ammount, 'email': event.email},
        'transfer_point_to_friend');
    if (response == 'success') {
      emit(TransferSuccessState());
    } else {
      emit(TransferFaildState(response));
    }
  }
}
