class OfferModel {
  final int id;
  final String name;
  final String description;
  // ignore: prefer_typing_uninitialized_variables
  var points;
  final DateTime endsIn;
  final List<String> imageList;

  OfferModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.points,
      required this.endsIn,
      required this.imageList});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      points: json['points'],
      endsIn: DateTime.parse(json['end_time']),
      imageList: json['images'][0]['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
        "description": description,
        "points": points,
        "endsIn": endsIn,
        "image": imageList,
      };
}
