class NewNotificationModel {
  int statusCode;
  String message;

  NewNotificationModel({
    required this.statusCode,
    required this.message,
  });

  factory NewNotificationModel.fromJson(Map<String, dynamic> json) {
    return NewNotificationModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
