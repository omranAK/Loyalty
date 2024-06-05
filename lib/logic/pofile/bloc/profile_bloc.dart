import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:loyalty_system_mobile/data/models/user_model.dart';
import 'package:loyalty_system_mobile/data/repository/profile_repo.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _profileRepository;
  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<GetProfileDataEvent>(_onGetProfileEvent);
    on<UpdateUserDataEvent>(_onUpdateUserDataEvent);
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
    emit(ProfileLoadingState());
    var response = await _profileRepository.updateUserData(
        event.user.toJson(), 'update_client_profile');
    if (response is String) {
      emit(ProfileFaildState(response));
    } else {
      emit(ProfileloaddedState(response));
    }
  }
}
