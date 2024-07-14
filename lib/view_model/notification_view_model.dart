import 'package:flutter/material.dart';
import 'package:oha/models/notification/notification_model.dart';

import '../network/api_response.dart';
import '../repository/notification_repository.dart';

class NotificationViewModel with ChangeNotifier {
  final _notificationRepository = NotificationRepository();

  ApiResponse<NotificationModel> notificationsData = ApiResponse.loading();

    void setNotifications(ApiResponse<NotificationModel> response) {
    notificationsData = response;
    notifyListeners();
  }

  Future<void> getNotification(Map<String, dynamic> data) async {
    await _notificationRepository.notify(data).then((value) {
      setNotifications(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setNotifications(ApiResponse.error(error.toString()));
    });
  }
}
