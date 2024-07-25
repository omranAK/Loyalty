import 'package:loyalty_system_mobile/data/models/user_model.dart';
import 'package:loyalty_system_mobile/data/models/user_setting_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class ProfileRepository extends GeneralController {
  final ExternalService _externalService;

  ProfileRepository({required ExternalService externalService})
      : _externalService = externalService;

  Future getUserData(
      Map<String, dynamic> queryParameters, String urlService) async {
    User user;
    var response = await _externalService.getData(queryParameters, urlService);

    if (returnCodeFunc(response) == 'success') {
      user = User.fromJson(response.the0);
      return user;
    } else {
      return returnCodeFunc(response);
    }
  }

  Future updateUserData(
      Map<String, dynamic> queryParameters, String urlService) async {
    User user;
    var response =
        await _externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      
      user = User.fromJson(response.the0['user']);
      // var response1 = await _externalService.getData(
      //     queryParameters, 'show_profile/${CacheManager.getUserModel()!.id}');
      // user = User.fromJson(response1.the0);
      UserSetting userSetting =
          CacheManager.getUserModel()!.copyWith(name: user.name);
        
      await CacheManager.setUserModel(userSetting);
      return user;
    } else {
      return returnCodeFunc(response);
    }
  }
}
