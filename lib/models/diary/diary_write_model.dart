class DiaryWriteModel {
  int statusCode;
  String message;

  DiaryWriteModel(
      {required this.statusCode, required this.message});

  factory DiaryWriteModel.fromJson(Map<String, dynamic> json) {
    return DiaryWriteModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}