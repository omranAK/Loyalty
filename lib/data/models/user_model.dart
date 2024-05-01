class User {
  final String id;
  final String name;
  final String email;
  final String phonenumber;
  final double points;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phonenumber,
      required this.points});

  factory User.fromJason(Map<String, dynamic> json) => User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phonenumber: json['phonenumber'],
      points: json['points']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phonenumber": phonenumber,
        "points": points
      };
}
