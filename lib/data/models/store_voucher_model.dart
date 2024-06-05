class StoreVoucherModel {
  final int id;
  final String name;
  final String description;
  var points;
  final int discount;
  final DateTime creatTime;

  StoreVoucherModel({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.discount,
    required this.creatTime,
  });

  factory StoreVoucherModel.fromJson(Map<String, dynamic> json) =>
      StoreVoucherModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        points: json['point'],
        discount: json['discount'],
        creatTime: DateTime.parse(json['created_at']),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "points": points,
        "discount": discount,
        "created_at": creatTime
      };
}
