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
    on<StoreInitialEvent>(_onStoreInitialEvent);
    on<LoadStoresEvent>(_onLoadStoresEvent);
    on<LoadStoreOffersEvent>(_onLoadStoreOffersEvent);
    on<LoadStoreVouchersEvent>(_onLoadStoreVouchersEvent);
    on<BuyVoucherButtonPressedEvent>(_onBuyVoucherButtonPressedEvent);
  }
  void _onStoreInitialEvent(
      StoreInitialEvent event, Emitter<StoresState> emit) async {
    emit(StoresInitial());
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

  void _onLoadStoreOffersEvent(
      LoadStoreOffersEvent event, Emitter<StoresState> emit) async {
    emit(OffersLoadingState());
    var response = await storeRepository.getOffers(
      {},
      'show_partner_offers/${event.storeID}',
    );

    if (response is String) {
      emit(OffersFailedState(errorMessage: response));
    } else {
      emit(OffersLoaddedState(offers: response));
    }
  }

  void _onLoadStoreVouchersEvent(
      LoadStoreVouchersEvent event, Emitter<StoresState> emit) async {
    var response = await storeRepository.getVoucheres(
      {},
      'show_partner_vouchers/${event.storeID}',
    );
    if (response is String) {
      emit(VocuhersFailedState(errorMessage: response));
    } else {
      emit(VouchersLoaddedState(vouchers: response));
    }
  }

  void _onBuyVoucherButtonPressedEvent(
      BuyVoucherButtonPressedEvent event, Emitter<StoresState> emit) async {
    emit(BuyingLoadingState());
    var response = await storeRepository
        .buyVoucher({}, 'buy_voucher/${event.voucherID}', event.points);
    if (response == 'success') {
      emit(BuyingSuccessState());
    } else {
      emit(
        BuyingFailedState(errorMessage: response),
      );
    }
  }
}
