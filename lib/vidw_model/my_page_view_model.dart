import 'package:flutter/cupertino.dart';
import 'package:oha/models/my_page/my_page_model.dart';
import 'package:oha/models/weather/weather_model.dart';
import 'package:oha/repository/my_page_repository.dart';

import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class MyPageViewModel with ChangeNotifier {
  final _mypageRepository = MyPageRepository();

  ApiResponse<MyPageModel> _MyPageData = ApiResponse.loading();

  setMyPageData(ApiResponse<MyPageModel> response) {
    _MyPageData = response;
  }

  Future<void> changeNickName(Map<String, dynamic> data) async {
    await _mypageRepository.changeUserNickName(data).then((value) {
      print("Jehee : ${value}");
      setMyPageData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setMyPageData(ApiResponse.error(error.toString()));
    });
  }
}
