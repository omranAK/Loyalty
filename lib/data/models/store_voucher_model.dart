class StoreVoucherModel {
  final int id;
  final String name;
  final String description;
  var points;
  final int discount;

  StoreVoucherModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.points,
      required this.discount});

  factory StoreVoucherModel.fromJson(Map<String, dynamic> json) =>
      StoreVoucherModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        points: json['point'],
        discount: json['discount'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "points": points,
        "discount": discount,
      };
}
