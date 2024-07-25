import 'package:loyalty_system_mobile/data/models/notification_model.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class NotificationsRepository extends GeneralController {
  final ExternalService externalService;

  NotificationsRepository({required this.externalService});

  Future loadNotifications(
      Map<String, dynamic> queryParameters, String urlService) async {
    NotificationModel notificationModel;
    List<NotificationModel> notificationsList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      List responseList = response.the0;
      for (var element in responseList) {
        notificationModel = NotificationModel.fromJson(element);
        notificationsList.add(notificationModel);
      }
      return notificationsList;
    } else {
      return returnCodeFunc(response);
    }
  }

  Future registerToken(
      Map<String, dynamic> queryParameters, String urlService) async {
    
        await externalService.postDataMap1(queryParameters, urlService);
  }
}
