import 'package:loyalty_system_mobile/data/models/offer_model.dart';
import 'package:loyalty_system_mobile/data/models/store_model.dart';
import 'package:loyalty_system_mobile/data/models/store_voucher_model.dart';
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
    List<OfferModel> offerList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      list = response.the0;
      list.forEach(
        (element) {
        
          offerModel = OfferModel.fromJson(element);
          offerList.add(offerModel);
        },
      );
      return offerList;
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
      list = response.the0;
      list.forEach(
        (element) { 
          voucherModel = StoreVoucherModel.fromJson(element);
          voucherList.add(voucherModel);
        },
      );
      return voucherList;
    }
    return returnCodeFunc(response);
  }

}
