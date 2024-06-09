class UploadDeleteModel {
  int statusCode;
  String message;

  UploadDeleteModel({
    required this.statusCode,
    required this.message,
  });

  factory UploadDeleteModel.fromJson(Map<String, dynamic> json) {
    return UploadDeleteModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

