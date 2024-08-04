// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:loyalty_system_mobile/constant/imports.dart';
import 'package:loyalty_system_mobile/data/web_services/general_controller.dart';

class HistortyRepository extends GeneralController {
  ExternalService externalService;
  HistortyRepository({
    required this.externalService,
  });

  Future getHistory(
      Map<String, dynamic> queryParameters, String urlService) async {
    PointHistoryModel pointHistoryModel;
    List historyFrom = [];
    List historyTo = [];
    List<PointHistoryModel> historyList = [];
    var response = await externalService.getData(queryParameters, urlService);
    
    if (returnCodeFunc(response) == 'success' &&response.the0 !=null) {
      historyFrom = response.the0['histories_from'];
      historyTo = response.the0['histories_to'];
      for (var element in historyFrom) {
        pointHistoryModel = PointHistoryModel(
            id: element['id'],
            operation: element['operation'],
            ammount: element['transfer_points'],
            time: DateTime.parse(element['transfer_time']),
            otherSideName: element['user_to']['name'],
            otherSideEmail: element['user_to']['email'],
            up: true);
        historyList.add(pointHistoryModel);
      }
      for (var element in historyTo) {
        pointHistoryModel = PointHistoryModel(
            id: element['id'],
            operation: element['operation'],
            ammount: element['transfer_points'],
            time: DateTime.parse(element['transfer_time']),
            otherSideName: element['user_from']['name'],
            otherSideEmail: element['user_from']['email'],
            up: false);
        historyList.add(pointHistoryModel);
      }

      historyList.sort((a, b) => a.time.compareTo(b.time));
      List<PointHistoryModel> finalList = historyList.reversed.toList();
      return finalList;
    } else {
      return response.message;
    }
  }
}
