// ignore_for_file: public_member_api_docs, sort_constructors_first
class CharityModel {
  final int id;
  final String name;
  final String email;
  final String description;
  final String? profImg;
  final String location;
  final String phone;
  CharityModel({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.profImg,
    required this.location,
    required this.phone,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      description: json['charity']['about'],
      profImg: json['prof_img'],
      location: json['charity']['location'],
      phone: json['phone']);
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "description": description,
        "prof_img": profImg,
        "location": location,
        "phone": phone
      };
}
