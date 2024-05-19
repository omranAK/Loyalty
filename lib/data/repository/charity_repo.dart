import 'package:loyalty_system_mobile/data/models/charity_model.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class CharityRepository extends GeneralController {
  final ExternalService externalService;

  CharityRepository({required this.externalService});

  Future getCharity(
      Map<String, dynamic> queryParameters, String urlService) async {
    CharityModel storeModel;
    List list = [];
    List<CharityModel> charity_list = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      
      list = response.the0;
      list.forEach(
        (element) {
          storeModel = CharityModel.fromJson(element);
          charity_list.add(storeModel);
        },
      );
      return charity_list;
    }
    return returnCodeFunc(response);
  }
}
