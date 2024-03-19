class AllLocationModel {
  int statusCode;
  String message;
  LocationData data;

  AllLocationModel(
      {required this.statusCode, required this.message, required this.data});

  factory AllLocationModel.fromJson(Map<String, dynamic> json) {
    return AllLocationModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? LocationData.fromJson(json['data'])
          : LocationData(locations: {}),
    );
  }
}

class LocationData {
  Map<String, Map<String, List<AllLocation>>> locations;

  LocationData({required this.locations});

  factory LocationData.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, List<AllLocation>>> locations = {};

    json.forEach((province, cities) {
      Map<String, List<AllLocation>> cityMap = {};
      cities.forEach((city, districts) {
        List<AllLocation> districtList = [];
        for (var district in districts) {
          districtList.add(AllLocation.fromJson(district));
        }
        cityMap[city] = districtList;
      });
      locations[province] = cityMap;
    });
    return LocationData(locations: locations);
  }
}

class AllLocation {
  String address;
  String code;

  AllLocation({required this.address, required this.code});

  factory AllLocation.fromJson(Map<String, dynamic> json) {
    return AllLocation(
      address: json['address'] ?? '',
      code: json['code'] ?? '',
    );
  }
}
