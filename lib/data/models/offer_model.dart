class OfferModel {
  final int id;
  final String name;
  final String description;
  var points;
  final DateTime endsIn;
  final String image;

  OfferModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.points,
      required this.endsIn,
      required this.image});

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      points: json['points'],
      endsIn: DateTime.parse(json['end_time']),
      image: json['images'][0]['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
        "description": description,
        "points": points,
        "endsIn": endsIn,
        "image": image,
      };
}
