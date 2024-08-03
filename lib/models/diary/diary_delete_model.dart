class DiaryDeleteModel {
  int statusCode;
  String message;

  DiaryDeleteModel(
      {required this.statusCode, required this.message});

  factory DiaryDeleteModel.fromJson(Map<String, dynamic> json) {
    return DiaryDeleteModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}