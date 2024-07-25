// ignore_for_file: public_member_api_docs, sort_constructors_first

class VoucherModel {
  final int id;
  final int isValid;
  final String name;
  final String description;
  // ignore: prefer_typing_uninitialized_variables
  var points;
  final int discount;
  final String storeNmae;
  final DateTime expDate;

  VoucherModel(
      {required this.id,
      required this.isValid,
      required this.name,
      required this.description,
      required this.points,
      required this.discount,
      required this.storeNmae,
      required this.expDate});

  // Voucher copyWith({
  //   int? id,
  //   int? isValid,
  //   String? name,
  //   String? description,
  //   double? points,
  //   int? discount,
  //   String? storeNmae,
  // }) {
  //   return Voucher(
  //     id: id ?? this.id,
  //     isValid: isValid ?? this.isValid,
  //     name: name ?? this.name,
  //     description: description ?? this.description,
  //     points: points ?? this.points,
  //     discount: discount ?? this.discount,
  //     storeNmae: storeNmae ?? this.storeNmae,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'isValid': isValid,
  //     'name': name,
  //     'description': description,
  //     'points': points,
  //     'discount': discount,
  //     'storeNmae': storeNmae,
  //   };
  // }

  // factory Voucher.fromMap(Map<String, dynamic> map) {
  //   return Voucher(
  //     id: map['id'] as int,
  //     isValid: map['isValid'] as int,
  //     name: map['name'] as String,
  //     description: map['description'] as String,
  //     points: map['points'] as double,
  //     discount: map['discount'] as int,
  //     storeNmae: map['storeNmae'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  factory VoucherModel.fromJson(Map<String, dynamic> json) => VoucherModel(
      id: json['voucher']['id'],
      isValid: json['valid'],
      name: json['voucher']['name'],
      description: json['voucher']['description'],
      points: json['voucher']['point'],
      discount: json['voucher']['discount'],
      storeNmae: json['voucher']['partner']['name'],
      expDate: DateTime.parse(json['exp_date']));

  @override
  String toString() {
    return 'Voucher(id: $id, isValid: $isValid, name: $name, description: $description, points: $points, discount: $discount, storeNmae: $storeNmae)';
  }

  @override
  bool operator ==(covariant VoucherModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isValid == isValid &&
        other.name == name &&
        other.description == description &&
        other.points == points &&
        other.discount == discount &&
        other.storeNmae == storeNmae;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isValid.hashCode ^
        name.hashCode ^
        description.hashCode ^
        points.hashCode ^
        discount.hashCode ^
        storeNmae.hashCode;
  }
}
