import 'package:loyalty_system_mobile/data/storage/cache_manager.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profImg;
  // ignore: prefer_typing_uninitialized_variables
  var points;
  // ignore: prefer_typing_uninitialized_variables
  var spicialPoins;
  final String? about;
  final String? location;

  // final double points;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.profImg,
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
        profImg: json['prof_img'],
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
        "prof_img": profImg,
        "points": points,
        "spicialPoins": spicialPoins
        // "points": points
      };
}
