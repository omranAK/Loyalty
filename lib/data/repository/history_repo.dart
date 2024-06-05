// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:loyalty_system_mobile/data/models/point_history_model.dart';
import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';
import 'package:loyalty_system_mobile/data/web_services/external_services.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class HistortyRepository extends GeneralController {
  ExternalService externalService;
  HistortyRepository({
    required this.externalService,
  });

  Future getHistory(
      Map<String, dynamic> queryParameters, String urlService) async {
    PointHistoryModel pointHistoryModel;
    List history_from = [];
    List history_to = [];
    List<PointHistoryModel> historyList = [];
    var response = await externalService.getData(queryParameters, urlService);
    if (returnCodeFunc(response) == 'success') {
      history_from = response.the0['histories_from'];
      history_to = response.the0['histories_to'];
      history_from.forEach((element) {
        pointHistoryModel = PointHistoryModel(
          id: element['id'],
          operation: element['operation'],
          ammount: element['transfer_points'],
          time: DateTime.parse(element['transfer_time']),
          otherSideName: element['user_to']['name'],
          otherSideEmail: element['user_to']['email'],
          up: true
        );
        historyList.add(pointHistoryModel);
      });
      history_to.forEach((element) {
        pointHistoryModel = PointHistoryModel(
          id: element['id'],
          operation: element['operation'],
          ammount: element['transfer_points'],
          time: DateTime.parse(element['transfer_time']),
          otherSideName: element['user_from']['name'],
          otherSideEmail: element['user_from']['email'],
          up: false
        );
        historyList.add(pointHistoryModel);
      });

      historyList.sort((a, b) => a.time.compareTo(b.time));
      List<PointHistoryModel> finalList = historyList.reversed.toList();
      return finalList;
    } else {
      
      return response.message;
    }
  }
}
