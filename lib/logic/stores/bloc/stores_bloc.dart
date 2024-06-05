// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/offer_model.dart';

import 'package:loyalty_system_mobile/data/models/store_model.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:loyalty_system_mobile/data/repository/store_repo.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  StoreRepository storeRepository;
  StoresBloc(
    this.storeRepository,
  ) : super(StoresInitial()) {
    on<LoadStoresEvent>(_onLoadStoresEvent);
    on<LoadStoreDetailesEvent>(_onLoadStoreDetailesEvent);
  }
  void _onLoadStoresEvent(
      LoadStoresEvent event, Emitter<StoresState> emit) async {
    emit(StoresLoadingState());
    var response = await storeRepository.getStores({}, 'show_partners');
    if (response is String) {
      emit(StoresFailedState(response));
    } else {
      emit(StoresLoaddedState(response));
    }
  }

  void _onLoadStoreDetailesEvent(
      LoadStoreDetailesEvent event, Emitter<StoresState> emit) async {
    emit(DetailesLoadingState());
    var response = await storeRepository.getOffers(
      {},
      'show_partner_offers/${event.storeID}',
    );
    var response1 = await storeRepository.getVoucheres(
      {},
      'show_partner_vouchers/${event.storeID}',
    );

    if (response1 is String) {
      emit(DetailesFaildState(errorMessage: response1));
    } else if (response is String) {
      emit(DetailesFaildState(errorMessage: response));
    } else {
      emit(DetailesLoaddedState(offers: response, vouchers: response1));
    }
  }

  
}
