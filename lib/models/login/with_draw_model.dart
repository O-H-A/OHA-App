class WithDrawModel {
  int statusCode;
  String message;

  WithDrawModel({required this.statusCode, required this.message});

  factory WithDrawModel.fromJson(Map<String, dynamic> json) {
    return WithDrawModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
