import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:oha/models/my_page/name_update_model.dart';
import 'package:oha/models/weather/weather_model.dart';
import 'package:oha/repository/my_page_repository.dart';

import '../models/my_page/my_info_model.dart';
import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class MyPageViewModel with ChangeNotifier {
  final _mypageRepository = MyPageRepository();

  ApiResponse<NameUpdateModel> myPageData = ApiResponse.loading();
  ApiResponse<MyInfoModel> myInfoData = ApiResponse.loading();

  setMyPageData(ApiResponse<NameUpdateModel> response) {
    myPageData = response;
    notifyListeners();
  }

  setMyInfoData(ApiResponse<MyInfoModel> response) {
    myInfoData = response;
    notifyListeners();
  }

  Future<int> changeUserInfo(Map<String, dynamic> data, Uint8List? image) async {
    final result = await _mypageRepository.changeUserInfo(data, image);

    return result.statusCode;
  }

  Future<void> myInfo() async {
    await _mypageRepository.myInfo().then((value) {
      setMyInfoData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setMyInfoData(ApiResponse.error(error.toString()));
    });
  }
}
