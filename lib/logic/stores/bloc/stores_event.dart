part of 'stores_bloc.dart';

sealed class StoresEvent extends Equatable {
  const StoresEvent();

  @override
  List<Object> get props => [];
}

final class StoreInitialEvent extends StoresEvent {}

final class LoadStoresEvent extends StoresEvent {}

final class LoadStoreOffersEvent extends StoresEvent {
  final int storeID;

  const LoadStoreOffersEvent({required this.storeID});
}

final class LoadStoreVouchersEvent extends StoresEvent {
  final int storeID;

  const LoadStoreVouchersEvent({required this.storeID});
}

// ignore: must_be_immutable
final class BuyVoucherButtonPressedEvent extends StoresEvent {
  final int voucherID;
  var points;
  BuyVoucherButtonPressedEvent({
    required this.voucherID,
    required this.points,
  });
}
