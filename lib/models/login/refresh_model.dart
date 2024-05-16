class RefreshModel {
  int statusCode;
  String message;
  RefreshData data;

  RefreshModel({
    required this.statusCode,
    required this.message,
    required this.data
  });

  factory RefreshModel.fromJson(Map<String, dynamic> json) {
    return RefreshModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: RefreshData.fromJson(json['data'] ?? {}),
    );
  }
}

class RefreshData {
  String accessToken;

  RefreshData({
    required this.accessToken,
  });

  factory RefreshData.fromJson(Map<String, dynamic> json) {
    return RefreshData(
      accessToken: json['accessToken'] ?? '',
    );
  }
}