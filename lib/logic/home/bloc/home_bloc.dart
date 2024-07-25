// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/voucher_model.dart';
import 'package:loyalty_system_mobile/data/repository/home_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepo;
  HomeBloc(this._homeRepo) : super(HomeInitial()) {
    on<HomeInitialEvent>(_onHomeInitialEvent);
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
    on<GetHomeDateEvent>(_onGetHomeDateEvent);
    on<ConsumeVoucherEvent>(_onConsumeVoucherEvent);
    on<GenerateOtpEvent>(_onGenerateOtpEvent);
  }
  void _onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeInitial());
  }

  void _onLogoutButtonPressedEvent(
      LogoutButtonPressedEvent event, Emitter<HomeState> emit) async {
    var response = await _homeRepo.logout({}, 'auth/logout');
    if (response == 'success') {
      emit(LogoutSuccessState());
    } else {
      emit(LogoutFaildState());
    }
  }

  void _onGetHomeDateEvent(
      GetHomeDateEvent event, Emitter<HomeState> emit) async {
    emit(DataLoadingState());
    var response = await _homeRepo.getMyVoucher({}, 'show_my_bought_voucher');
    var response1 = await _homeRepo
        .getMyPoints({}, 'show_profile/${CacheManager.getUserModel()!.id}');
    var response2 = await _homeRepo
        .getMyEmail({}, 'show_profile/${CacheManager.getUserModel()!.id}');
    if (response is String) {
      emit(DataFaildState(response));
    } else {
      emit(DataLoadedState(response1, response, response2));
    }
  }

  // void _onGetHomeDateEvent(
  //     GetHomeDateEvent event, Emitter<HomeState> emit) async {
  //   emit(DataLoadingState());
  //   var response = await _homeRepo.getMyVoucher({}, 'show_my_bought_voucher');
  //   var response1 = await _homeRepo.getMyPoints(
  //       {"email": "omran.alakad@gmail.com", "password": "ammA1234"},
  //       'auth/login');
  //   var response2 = await _homeRepo
  //       .getMyEmail({}, 'show_profile/${CacheManager.getUserModel()!.id}');
  //   if (response is String) {
  //     emit(DataFaildState(response));
  //   } else {
  //     emit(DataLoadedState(response1, response, response2));
  //   }
  // }

  void _onConsumeVoucherEvent(
      ConsumeVoucherEvent event, Emitter<HomeState> emit) async {
    emit(ConsumingLoaadingState());
    String response =
        await _homeRepo.useVoucher({}, 'use_voucher/${event.voucherID}');
    if (response.contains('message')) {
      emit(ConsumingFailedState(errorMessage: response));
    } else {
      emit(ConsumingSuccessState(otp: response));
    }
  }

  void _onGenerateOtpEvent(
      GenerateOtpEvent event, Emitter<HomeState> emit) async {
    emit(GenerateOtpLoadingState());
    String response =
        await _homeRepo.generateOtp({}, 'Charity_Client_generate_otp');
    if (response.contains('message')) {
      emit(GenerateOtpFailedState(errorMessage: response));
    } else {
      emit(GenerateOtpSuccessState(otp: response));
    }
  }
}
