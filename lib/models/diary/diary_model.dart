class DiaryModel {
  final int statusCode;
  final String message;

  DiaryModel({
    required this.statusCode,
    required this.message,
  });

  factory DiaryModel.fromJson(Map<String, dynamic> json) {
    return DiaryModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
