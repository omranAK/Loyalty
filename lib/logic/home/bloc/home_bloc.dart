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
    on<LogoutButtonPressedEvent>(_onLogoutButtonPressedEvent);
    on<GetHomeDateEvent>(_onGetHomeDateEvent);
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
        .getMyPoints({}, 'show_profile/${CacheManager.getUserModel().id}');
    if (response is String) {
      emit(DataFaildState(response));
    } else {
      emit(DataLoadedState(response1, response));
    }
  }
}
