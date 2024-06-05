part of 'stores_bloc.dart';

sealed class StoresEvent extends Equatable {
  const StoresEvent();

  @override
  List<Object> get props => [];
}

final class LoadStoresEvent extends StoresEvent {}

final class LoadStoreDetailesEvent extends StoresEvent {
  final int storeID;

  const LoadStoreDetailesEvent({required this.storeID});
}

// final class BuyVoucherButtonPressedEvent extends StoresEvent{
//   final int voucherID;

//  const  BuyVoucherButtonPressedEvent({required this.voucherID});
// }