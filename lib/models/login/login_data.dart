class LoginData {
  String type;
  bool isNameExist;
  String accessToken;
  String refreshToken;

  LoginData({
    required this.type,
    required this.isNameExist,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      type: json['type'] ?? '',
      isNameExist: json['isNameExist'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
