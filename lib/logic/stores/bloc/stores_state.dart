part of 'stores_bloc.dart';

sealed class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object> get props => [];
}

final class StoresInitial extends StoresState {}

final class StoresLoadingState extends StoresState {}

final class StoresLoaddedState extends StoresState {
  final List<StoreModel> storeModel;

  const StoresLoaddedState(this.storeModel);
}

final class StoresFailedState extends StoresState {
  final String errorMessage;

  const StoresFailedState(this.errorMessage);
}

final class OffersLoadingState extends StoresState {}

final class OffersLoaddedState extends StoresState {
  final List<OfferModel> offers;
  const OffersLoaddedState({
    required this.offers,
  });
}

final class OffersFailedState extends StoresState {
  final String errorMessage;

  const OffersFailedState({required this.errorMessage});
}

final class VouchersLoadingState extends StoresState {}

final class VouchersLoaddedState extends StoresState {
  final List<StoreVoucherModel> vouchers;
  const VouchersLoaddedState({
    required this.vouchers,
  });
}

final class VocuhersFailedState extends StoresState {
  final String errorMessage;

  const VocuhersFailedState({required this.errorMessage});
}

final class BuyingLoadingState extends StoresState {}

final class BuyingSuccessState extends StoresState {}

final class BuyingFailedState extends StoresState {
  final String errorMessage;

  const BuyingFailedState({required this.errorMessage});
}
