import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/data/models/store_model.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class StoreRepository extends GeneralController {
  final ExternalService externalService;

  StoreRepository({required this.externalService});

  Future getStores(
      Map<String, dynamic> queryParameters, String urlService) async {
    StoreModel storeModel;
    List list = [];
    List<StoreModel> stores_list = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      list = response.the0;
      list.forEach(
        (element) {
          storeModel = StoreModel.fromJson(element);
          stores_list.add(storeModel);
        },
      );
      return stores_list;
    }
    return returnCodeFunc(response);
  }

  Future getOffers(
      Map<String, dynamic> queryParameters, String urlService) async {
    OfferModel offerModel;
    List list = [];
    List image = [];
    List<OfferModel> offerList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      if (response.the0 != []) {
        list = response.the0;
        list.forEach(
          (element) {
            List<String> img = [];
            image = element['images'];
            image.forEach((element) {
              img.add(element['name']);
            });
            offerModel = OfferModel(
              id: element['id'],
              name: element['title'],
              description: element['description'],
              points: element['points'],
              endsIn: DateTime.parse(element['end_time']),
              imageList: img,
            );
            offerList.add(offerModel);
          },
        );
        return offerList;
      } else {
        return 'This store does not have offers ';
      }
    }
    return returnCodeFunc(response);
  }

  Future getVoucheres(
      Map<String, dynamic> queryParameters, String urlService) async {
    StoreVoucherModel voucherModel;
    List list = [];
    List<StoreVoucherModel> voucherList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      if (response.the0 != []) {
        list = response.the0;
        list.forEach(
          (element) {
            voucherModel = StoreVoucherModel.fromJson(element);
            voucherList.add(voucherModel);
          },
        );
        voucherList.sort((a, b) => a.creatTime.compareTo(b.creatTime));
        List<StoreVoucherModel> finalList = voucherList.reversed.toList();
        return finalList;
      } else {
        return 'This store does not have vouchers ';
      }
    }
    return returnCodeFunc(response);
  }

  Future buyVoucher(Map<String, dynamic> queryParameters, String urlService,
      var points) async {
    var response =
        await externalService.postDataMap1(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      double old = double.tryParse(CacheManager.getPoint()!)!;
      var point = old - points;
      CacheManager.setPoint(point.toString());
      return 'success';
    } else {
      return response.message;
    }
  }
}
