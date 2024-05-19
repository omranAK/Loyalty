class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? prof_img;
  var points;
  var spicialPoins;

  // final double points;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.prof_img,
    required this.points,
    required this.spicialPoins,

    // required this.points
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      prof_img: json['prof_img'],
      points: json['client']['points'],
      spicialPoins: json['client']['special_points']

      // points: json['points']
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "prof_img": prof_img,
        "points": points,
        "spicialPoins": spicialPoins
        // "points": points
      };
}
