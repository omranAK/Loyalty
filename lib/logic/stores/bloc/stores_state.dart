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

final class DetailesLoadingState extends StoresState {}

final class DetailesLoaddedState extends StoresState {
  final List<OfferModel> offers;
  final List<StoreVoucherModel> vouchers;
  const DetailesLoaddedState({
    required this.offers,
    required this.vouchers,
  });
}

final class DetailesFaildState extends StoresState {
  final String errorMessage;

  const DetailesFaildState({required this.errorMessage});
}

final class BuyingLoadingState extends StoresState {}

final class BuyingSuccessState extends StoresState {}

final class BuyingFaildState extends StoresState {
  final String errorMessage;

  const BuyingFaildState({required this.errorMessage});
}
