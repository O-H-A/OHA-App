class NameUpdateModel {
  int statusCode;
  String message;

  NameUpdateModel(
      {required this.statusCode, required this.message});

  factory NameUpdateModel.fromJson(Map<String, dynamic> json) {
    return NameUpdateModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}