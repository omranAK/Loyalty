// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class TransferRepository extends GeneralController {
  ExternalService externalService;
  TransferRepository(
    this.externalService,
  );
  Future makeTranfer(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.postDataMap1({
      'points': queryParameters['points'].toString(),
      'email': queryParameters['email']
    }, urlService);
    if (returnCodeFunc(response) == 'success') {
      double old = double.tryParse(CacheManager.getPoint()!)!;
      var point = old - queryParameters['points'];
      CacheManager.setPoint(point.toString());
      return 'success';
    } else {
      return returnCodeFunc(response);
    }
  }

  Future getUserPoints(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      return response.the0['client']['points'];
    } else {
      return returnCodeFunc(response);
    }
  }

  Future useVoucher(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      return response.the0;
    } else {
      return returnCodeFunc(response);
    }
  }
}
