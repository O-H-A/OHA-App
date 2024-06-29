import 'package:flutter/cupertino.dart';
import 'package:oha/models/my_page/name_update_model.dart';
import 'package:oha/models/weather/weather_model.dart';
import 'package:oha/repository/my_page_repository.dart';

import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class MyPageViewModel with ChangeNotifier {
  final _mypageRepository = MyPageRepository();

  ApiResponse<NameUpdateModel> _MyPageData = ApiResponse.loading();

  setMyPageData(ApiResponse<NameUpdateModel> response) {
    _MyPageData = response;
  }

  Future<void> changeNickName(Map<String, dynamic> data) async {
    await _mypageRepository.changeUserNickName(data).then((value) {
      setMyPageData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setMyPageData(ApiResponse.error(error.toString()));
    });
  }
}
