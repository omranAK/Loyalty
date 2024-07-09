class Ad {
  final int id;
  final String name;
  final String description;
  final String url;

  Ad({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json['id'],
        name: json['title'],
        description: json['description'],
        url: json['media'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
      };
}
