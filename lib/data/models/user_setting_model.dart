// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserSetting {
  final String name;
  final String token;
  final int id;
  final int active;
  final int roleID;
  //final String barcode;
  UserSetting({
    required this.name,
    required this.token,
    required this.id,
    required this.active,
    required this.roleID,
    //  required this.barcode,
  });

  UserSetting copyWith({
    String? name,
    String? token,
    int? id,
    int? active,
    int? roleID,
    //   String? barcode,
  }) {
    return UserSetting(
      name: name ?? this.name,
      token: token ?? this.token,
      id: id ?? this.id,
      active: active ?? this.active,
      roleID: roleID ?? this.roleID,
      //   barcode: barcode ?? this.barcode,
    );
  }

  factory UserSetting.fromJson(Map<String, dynamic> json) => UserSetting(
        name: json['name'],
        token: json['token'],
        id: json['id'],
        active: json['active'],
        roleID: json['roleID'],
        //   barcode: json['barcode'],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "token": token,
        "id": id,
        "active": active,
        "roleID": roleID,
        // "barcode": barcode
        // "points": points
      };
}
