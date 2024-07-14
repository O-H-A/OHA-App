class UploadReportModel {
  int statusCode;
  String message;

  UploadReportModel({
    required this.statusCode,
    required this.message,
  });

  factory UploadReportModel.fromJson(Map<String, dynamic> json) {
    return UploadReportModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}

