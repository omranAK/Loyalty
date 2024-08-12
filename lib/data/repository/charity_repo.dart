import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class CharityRepository extends GeneralController {
  final ExternalService externalService;

  CharityRepository({required this.externalService});

  Future getCharity(
      Map<String, dynamic> queryParameters, String urlService) async {
    CharityModel storeModel;
    List list = [];
    List<CharityModel> charityList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      if (response.the0 != []) {
        list = response.the0;
        for (var element in list) {
          storeModel = CharityModel.fromJson(element);
          charityList.add(storeModel);
        }
        return charityList;
      } else {
        return 'No charity yet';
      }
    }
    return returnCodeFunc(response);
  }

  Future donate(Map<String, dynamic> queryParameters, String urlService) async {
    double? po = double.tryParse(queryParameters['points']);
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      double? old = double.tryParse(CacheManager.getSpicialPoint()!)!;
      var point = old - po!;
      CacheManager.setSpicialPoint(point.toString());
      return 'success';
    } else {
      return returnCodeFunc(response);
    }
  }

  Future getMyPoints(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      CacheManager.setSpicialPoint(
          response.the0['client']['special_points'].toString());
      return response.the0['client']['special_points'];
    } else {
      return returnCodeFunc(response);
    }
  }
}
