class LocationModel {
  int statusCode;
  String message;
  LocationData data;

  LocationModel(
      {required this.statusCode, required this.message, required this.data});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? LocationData.fromJson(json['data'])
          : LocationData(locations: {}),
    );
  }
}

class LocationData {
  Map<String, Map<String, List<String>>> locations;

  LocationData({required this.locations});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, List<String>>> locations = {};

    json.forEach((province, cities) {
      Map<String, List<String>> cityMap = {};
      cities.forEach((city, districts) {
        cityMap[city] = List<String>.from(districts);
      });
      locations[province] = cityMap;
    });
    return LocationData(locations: locations);
  }
}
