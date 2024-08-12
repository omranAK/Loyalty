// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/constant/imports.dart';
import 'package:loyalty_system_mobile/data/models/chart_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository;
  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<ProfileInitialEvent>(_onProfileInitialEvent);
    on<GetProfileDataEvent>(_onGetProfileEvent);
    on<UpdateUserDataEvent>(_onUpdateUserDataEvent);
    on<GetChartEvenet>(_onGetChartEvenet);
  }
  void _onProfileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileInitial());
  }

  void _onGetProfileEvent(
      GetProfileDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    var response = await _profileRepository
        .getUserData({}, 'show_profile/${CacheManager.getUserModel()!.id}');
    if (response is String) {
      emit(ProfileFaildState(response));
    } else {
      emit(ProfileloaddedState(response));
    }
  }

  void _onUpdateUserDataEvent(
      UpdateUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileUpdateLoadingState());

    var response = await _profileRepository.updateUserData({
      if (event.name != null) 'name': event.name,
      if (event.phone != null) 'phone': event.phone,
      if (event.description != null) 'about': event.description,
      if (event.location != null) 'location': event.location,
      'confirm_password': event.oldPassword,
      if (event.newPassword != null) 'password': event.newPassword
    }, 'update_account');
    if (response is String) {
      emit(ProfileUpdateFailedState(errorMessage: response));
    } else {
      emit(ProfileloaddedState(response));
    }
  }

  void _onGetChartEvenet(
      GetChartEvenet evenet, Emitter<ProfileState> emit) async {
    emit(ChartLoadingState());
    var response = await _profileRepository.getchart(
        {'user_id': CacheManager.getUserModel()!.id.toString()}, 'chart');
    if (response is String) {
      emit(ChartFailedState(errorMessage: response));
    } else {
      emit(ChartLoadedState(chart: response));
    }
  }
}
