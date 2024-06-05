import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? prof_img;
  var points;
  var spicialPoins;
  final String? about;
  final String? location;

  // final double points;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.prof_img,
      required this.points,
      this.spicialPoins,
      this.about,
      this.location

      // required this.points
      });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        prof_img: json['prof_img'],
        points: CacheManager.getUserModel()!.roleID == 4
            ? json['client']['points']
            : json['charity']['points'],
        spicialPoins: CacheManager.getUserModel()!.roleID == 4
            ? json['client']['special_points']
            : null,
        location: CacheManager.getUserModel()!.roleID == 4
            ? null
            : json['charity']['location'],
        about: CacheManager.getUserModel()!.roleID == 4
            ? null
            : json['charity']['about'],
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
