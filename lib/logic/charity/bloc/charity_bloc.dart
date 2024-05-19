// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/repository/charity_repo.dart';

part 'charity_event.dart';
part 'charity_state.dart';

class CharityBloc extends Bloc<CharityEvent, CharityState> {
  CharityRepository charityRepository;
  CharityBloc(
    this.charityRepository,
  ) : super(CharityInitial()) {
    on<LoadCharityEvent>(_onLoadCharityEvent);
  }
  void _onLoadCharityEvent(
      LoadCharityEvent event, Emitter<CharityState> emit) async {
    emit(CharityLoadingState());
    var response = await charityRepository.getCharity({}, 'show_all_charities');
    if (response is String) {
      emit(CharityFailedState(response));
    } else {
      emit(CharityLoaddedState(response));
    }
  }
}
