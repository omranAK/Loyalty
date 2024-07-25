// ignore_for_file: non_constant_identifier_names

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime created_at;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.created_at,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        created_at: DateTime.parse(
          json['created_at'],
        ),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "created_at": created_at,
      };
}
