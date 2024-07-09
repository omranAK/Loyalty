// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/repository/charity_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

part 'charity_event.dart';
part 'charity_state.dart';

class CharityBloc extends Bloc<CharityEvent, CharityState> {
  CharityRepository charityRepository;
  CharityBloc(
    this.charityRepository,
  ) : super(CharityInitial()) {
    on<CharityIntialEvent>(_onCharityIntialEvent);
    on<LoadCharityEvent>(_onLoadCharityEvent);
    on<DonateSpicialPointsEvent>(_onDonateSpicialPointsEvent);
  }
  void _onCharityIntialEvent(
      CharityIntialEvent event, Emitter<CharityState> emit) async {
    emit(CharityInitial());
  }

  void _onLoadCharityEvent(
      LoadCharityEvent event, Emitter<CharityState> emit) async {
    emit(CharityLoadingState());
    var response = await charityRepository.getCharity({}, 'show_all_charities');
    var response1 = await charityRepository
        .getMyPoints({}, 'show_profile/${CacheManager.getUserModel()!.id}');
    if (response is String) {
      emit(CharityFailedState(response));
    } else {
      emit(
        CharityLoaddedState(response, response1),
      );
    }
  }

  void _onDonateSpicialPointsEvent(
      DonateSpicialPointsEvent event, Emitter<CharityState> emit) async {
    emit(DonateLoadingState());
    var response = await charityRepository.donate(
      {
        'points': event.ammount,
        'id': event.charityID.toString(),
      },
      'donate_special_points',
    );
    if (response == 'success') {
      emit(DonateDoneState());
    } else {
      emit(
        DonateFailedState(errorMessage: response),
      );
    }
  }
}
