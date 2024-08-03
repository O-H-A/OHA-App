class DiaryUpdateModel {
  int statusCode;
  String message;

  DiaryUpdateModel(
      {required this.statusCode, required this.message});

  factory DiaryUpdateModel.fromJson(Map<String, dynamic> json) {
    return DiaryUpdateModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}