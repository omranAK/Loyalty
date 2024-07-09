import 'package:loyalty_system_mobile/data/models/ad_model.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class AdRepository extends GeneralController {
  final ExternalService externalService;

  AdRepository({required this.externalService});

  Future getAd(Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);
    Ad ad;
    if (returnCodeFunc(response) == 'success') {
      ad = Ad.fromJson(response.the0);
      return ad;
    } else {
      return returnCodeFunc(response);
    }
  }

  Future earnPoint(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      return 'success';
    } else {
      return 'false';
    }
  }
}
