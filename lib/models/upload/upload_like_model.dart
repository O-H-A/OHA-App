class UploadLikeModel {
  int statusCode;
  String message;

  UploadLikeModel({
    required this.statusCode,
    required this.message,
  });

  factory UploadLikeModel.fromJson(Map<String, dynamic> json) {
    return UploadLikeModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

