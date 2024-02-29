class MyPageModel {
  int statusCode;
  String message;

  MyPageModel(
      {required this.statusCode, required this.message});

  factory MyPageModel.fromJson(Map<String, dynamic> json) {
    return MyPageModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}