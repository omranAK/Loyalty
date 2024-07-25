// ignore_for_file: public_member_api_docs, sort_constructors_first


class StoreModel {
  final int id;
  final String name;
  final String category;
  final String location;
  final String description;
  final String? profImg;
  final String phone;
  StoreModel({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.description,
    required this.profImg,
    required this.phone,
  });

  StoreModel copyWith({
    int? id,
    String? name,
    String? category,
    String? location,
    String? description,
    String? profImg,
    String? phone,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      location: location ?? this.location,
      description: description ?? this.description,
      profImg: profImg ?? this.profImg,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category,
      'location': location,
      'description': description,
      'prof_img': profImg,
      'phone': phone,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] as int,
      name: map['name'] as String,
      category: map['category'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      profImg: map['prof_img'] as String,
      phone: map['phone'] as String,
    );
  }

factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
      id: json['id'],
      name: json['name'],
      category: json['partner']['category'],
      location: json['partner']['location'],
      description: json['partner']['about'],
      profImg: json['prof_img'],
      phone: json['phone']

    
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "location": location,
        "description": description,
        "prof_img": profImg,
        "phone": phone
       
      };





  @override
  bool operator ==(covariant StoreModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.category == category &&
        other.location == location &&
        other.description == description &&
        other.profImg == profImg &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        location.hashCode ^
        description.hashCode ^
        profImg.hashCode ^
        phone.hashCode;
  }
}
