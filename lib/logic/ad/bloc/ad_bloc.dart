// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/ad_model.dart';
import 'package:loyalty_system_mobile/data/repository/ad_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

part 'ad_event.dart';
part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final AdRepository adRepository;
  AdBloc(this.adRepository) : super(AdInitial()) {
    on<AdInitialEvent>(_onAdIntialEvent);
    on<LoadAdEvenet>(_onLoadAdEvenet);
    on<CompletedWatchAdEvent>(_onCompletedWatchAdEvent);
  }
  void _onAdIntialEvent(AdInitialEvent event, Emitter<AdState> emit) async {
    emit(AdInitial());
  }

  void _onLoadAdEvenet(LoadAdEvenet event, Emitter<AdState> emit) async {
    emit(AdLoadingState());
    var response = await adRepository.getAd({}, 'watch_ad');
    if (response is String) {
      emit(AdFaildState(errorMessage: response));
    } else {
      emit(AdLoaddedState(ad: response));
    }
  }

  void _onCompletedWatchAdEvent(
      CompletedWatchAdEvent event, Emitter<AdState> emit) async {
    await adRepository.earnPoint({},
        'get_points_from_ad/${CacheManager.getUserModel()!.id}/${event.adId}');
  }
}
