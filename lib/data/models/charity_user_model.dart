// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharityUserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String profImg;
  final String about;
  final String location;
  // ignore: prefer_typing_uninitialized_variables
  var points;
  CharityUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profImg,
    required this.about,
    required this.location,
    required this.points,
  });

  factory CharityUserModel.fromJson(Map<String, dynamic> json) =>
      CharityUserModel(
          id: json['id'],
          name: json['name'],
          email: json['email'],
          phone: json['phone'],
          profImg: json['prof_img'],
          about: json['charity']['about'],
          points: json['charity']['points'],
          location: json['charity']['location']

          // points: json['points']
          );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "prof_img": profImg,
        "about": about,
        "points": points,
        "location": location
        // "points": points
      };
}
