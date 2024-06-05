// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:loyalty_system_mobile/data/models/point_history_model.dart';
import 'package:loyalty_system_mobile/data/repository/history_repo.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistortyRepository histortyRepository;
  HistoryBloc(
    this.histortyRepository,
  ) : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_onLoadHistoryEvent);
  }

  void _onLoadHistoryEvent(
      LoadHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    var response =
        await histortyRepository.getHistory({}, 'show_points_history');
    if (response is String) {
      
      emit(HistoryFaildState(errorMessage: response));
    } else {
      emit(HistoryLoaddedState(history_list: response));
    }
  }
}
