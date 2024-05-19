import 'dart:async';
import 'package:loyalty_system_mobile/data/models/user_setting_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import '../web_services/general_controller.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';

class AuthRepository extends GeneralController {
  final ExternalService externalService;

  var token;

  AuthRepository({required this.externalService});

  Future login(Map<String, String> queryParameters, String urlService) async {
    UserSetting userSetting;
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == "success") {
      if (response.the0['role']['id'] == 4) {
        token = response.the0['access_token'];
        userSetting = UserSetting(
            name: response.the0['user']['name'],
            token: response.the0['access_token'],
            id: response.the0['user']['id'],
            active: response.the0['user']['active'],
            roleID: response.the0['role']['id']);
        CacheManager.setToken(token);
        CacheManager.setUserModel(userSetting);
        if (response.the0['user']['active'] == 1) {
          return userSetting;
        }
      } else {
        if (response.the0['user']['active'] != 1) {
          return 'You are not active';
        } else if (response.the0['role']['id'] != 4) {
          return 'You are not authenticated';
        }
      }
    } else {
      return returnCodeFunc(response);
    }
  }

  Future signup(Map<String, dynamic> queryParameters, String urlService) async {
    UserSetting userSetting;
    var response =
        await externalService.postDataMap(queryParameters, urlService);
    if (returnCodeFunc(response) == "success") {
      token = response.the0["access_token"];
      print(response.the0);
      userSetting = UserSetting(
          name: response.the0['user']['name'],
          token: response.the0['access_token'],
          id: response.the0['user']['id'],
          active: 0,
          roleID: response.the0['user']['role_id']);

      CacheManager.setToken(token);
      CacheManager.setUserModel(userSetting);
      return userSetting;
    } else {
      return returnCodeFunc(response);
    }
  }

  Future sendOtp() async {
    var response = await externalService.getData(null, 'generate_otp');
    if (returnCodeFunc(response) == 'success') {
      return 'success';
    } else {
      return 'faild';
    }
  }

  Future confirmEmail(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      UserSetting userSetting;
      userSetting = CacheManager.getUserModel();
      UserSetting newUserSetting = userSetting.copyWith(active: 1);
      CacheManager.setUserModel(newUserSetting);
      return 'success';
    } else {
      return 'faild';
    }
  }
}
