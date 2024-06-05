import 'dart:async';
import 'package:loyalty_system_mobile/data/models/voucher_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class HomeRepository extends GeneralController {
  final ExternalService externalService;

  HomeRepository(this.externalService);

  Future getMyVoucher(
      Map<String, dynamic> queryParameters, String urlService) async {
    VoucherModel voucher;
    List list = [];
    List<VoucherModel> voucherList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      list = response.the0;
      list.forEach(
        (element) {
          voucher = VoucherModel.fromJson(element);
          voucherList.add(voucher);
        },
      );
      return voucherList;
    }
    return returnCodeFunc(response);
  }

  Future getMyPoints(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);

    if (returnCodeFunc(response) == 'success') {
      if (CacheManager.getUserModel()!.roleID == 5) {
        return response.the0['charity']['points'];
      } else {
        return response.the0['client']['points'];
      }
    } else {
      return returnCodeFunc(response);
    }
  }

  Future getMyEmail(
      Map<String, dynamic> queryParameters, String urlService) async {
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      return response.the0['email'];
    } else {
      return returnCodeFunc(response);
    }
  }

  Future logout(Map<String, dynamic> queryParameters, String urlService) async {
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      CacheManager.clearSharedPreferences();
      return 'success';
    } else {
      return 'faild';
    }
  }
}
