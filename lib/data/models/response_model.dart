class ResponseModel {
  dynamic the0;
  int status;
  String message;

  ResponseModel({
    this.the0,
    required this.status,
    required this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(

    the0: json["0"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "0": the0,
    "status": status,
    "message": message,
  };
}
