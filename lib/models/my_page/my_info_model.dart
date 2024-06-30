class MyInfoModel {
  int statusCode;
  String message;
  MyInfoData data;

  MyInfoModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MyInfoModel.fromJson(Map<String, dynamic> json) {
    return MyInfoModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: MyInfoData.fromJson(json['data']),
    );
  }
}


class MyInfoData {
  int userId;
  String providerType;
  String email;
  String name;
  String? profileUrl;
  String createdAt;
  String updatedAt;

  MyInfoData({
    required this.userId,
    required this.providerType,
    required this.email,
    required this.name,
    required this.profileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyInfoData.fromJson(Map<String, dynamic> json) {
    return MyInfoData(
      userId: json['userId'] ?? 0,
      providerType: json['providerType'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profileUrl: json['profileUrl'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
