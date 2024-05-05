class LoginModel {
  int statusCode;
  String message;
  LoginData data;

  LoginModel({
    required this.statusCode,
    required this.message,
    required this.data
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginData {
  bool isJoined;
  bool isNameExist;
  String accessToken;
  String refreshToken;
  UserInfo userInfo;

  LoginData({
    required this.isJoined,
    required this.isNameExist,
    required this.accessToken,
    required this.refreshToken,
    required this.userInfo,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      isJoined: json['isJoined'] ?? false,
      isNameExist: json['isNameExist'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      userInfo: UserInfo.fromJson(json['userInfo'] ?? {}),
    );
  }
}

class UserInfo {
  String providerType;
  String? email;
  String? name;
  String? profileUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserInfo({
    required this.providerType,
    this.email,
    this.name,
    this.profileUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      providerType: json['providerType'] ?? '',
      email: json['email'],
      name: json['name'],
      profileUrl: json['profileUrl'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
