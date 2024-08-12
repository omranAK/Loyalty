class BestSellerModel {
  final int id;
  final String name;
  final String description;
  // ignore: prefer_typing_uninitialized_variables
  var points;
  final int discount;
  final String storeNmae;

  BestSellerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.points,
    required this.discount,
    required this.storeNmae,
  });
  factory BestSellerModel.fromJson(Map<String, dynamic> json) =>
      BestSellerModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        points: json['point'],
        discount: json['discount'],
        storeNmae: json['partner']['name'],
      );
}
