// ignore_for_file: public_member_api_docs, sort_constructors_first
class PointHistoryModel {
  final int id;
  final String operation;
   var ammount;
  final DateTime time;
  final String otherSideName;
  final String otherSideEmail;
  final bool up;

  PointHistoryModel({
    required this.id,
    required this.operation,
    required this.ammount,
    required this.time,
    required this.otherSideName,
    required this.otherSideEmail,
    required this.up
  });



  // factory PointHistoryModel.fromJson(Map<String, dynamic> json) => PointHistoryModel(
  //     id: json['id'],
  //     ammount: json['transfer_points'],
  //     time: json['transfer_time'],
  //     otherSideName: json['']['location'],
  //     description: json['partner']['about'],
  //     prof_img: json['prof_img'],
  //     phone: json['transfer_time']

    
  //     );
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "category": category,
  //       "location": location,
  //       "description": description,
  //       "prof_img": prof_img,
  //       "phone": phone
       
  //     };
}
