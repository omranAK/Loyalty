
class ChartModel {
  final Map<String,dynamic> points;

  ChartModel({
    required this.points,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) =>
      ChartModel(points: json);
}
