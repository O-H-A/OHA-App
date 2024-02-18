class FrequentLocationModel {
  int statusCode;
  String message;
  List<LocationItem> data;

  FrequentLocationModel({required this.statusCode, required this.message, required this.data});

  factory FrequentLocationModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<LocationItem> dataList = list.map((i) => LocationItem.fromJson(i)).toList();

    return FrequentLocationModel(
      statusCode: json['statusCode'] ??  0,
      message: json['message'] ?? '',
      data: dataList,
    );
  }
}

class LocationItem {
  String code;
  String firstAddress;
  String secondAddress;
  String thirdAddress;
  bool isHcode;
  bool isBcode;
  bool isDefault;

  LocationItem({
    required this.code,
    required this.firstAddress,
    required this.secondAddress,
    required this.thirdAddress,
    required this.isHcode,
    required this.isBcode,
    required this.isDefault,
  });

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    return LocationItem(
      code: json['code'] ?? '',
      firstAddress: json['firstAddress'] ?? '',
      secondAddress: json['secondAddress'] ?? '',
      thirdAddress: json['thirdAddress'] ?? '',
      isHcode: json['isHcode'] ?? false,
      isBcode: json['isBcode'] ?? false,
      isDefault: json['isDefault'] ?? false,
    );
  }
}