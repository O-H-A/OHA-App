class ChangeFrequentLocationModel {
  int statusCode;
  String message;

  ChangeFrequentLocationModel(
      {required this.statusCode, required this.message});

  factory ChangeFrequentLocationModel.fromJson(Map<String, dynamic> json) {
    return ChangeFrequentLocationModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}