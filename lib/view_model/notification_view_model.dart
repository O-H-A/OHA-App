import 'package:flutter/material.dart';
import 'package:oha/models/notification/new_notification_model.dart';
import 'package:oha/models/notification/notification_model.dart';

import '../network/api_response.dart';
import '../repository/notification_repository.dart';

class NotificationViewModel with ChangeNotifier {
  final _notificationRepository = NotificationRepository();

  ApiResponse<NotificationModel> notificationsData = ApiResponse.loading();

  ApiResponse<NewNotificationModel> checkNotificationData =
      ApiResponse.loading();

  void setNotifications(ApiResponse<NotificationModel> response) {
    notificationsData = response;
    notifyListeners();
  }

  void setCheckNotification(ApiResponse<NewNotificationModel> response) {
    checkNotificationData = response;
    notifyListeners();
  }

  Future<void> getNotification(Map<String, dynamic> data) async {
    await _notificationRepository.notify(data).then((value) {
      setNotifications(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setNotifications(ApiResponse.error(error.toString()));
    });
  }

  Future<void> checkNotification() async {
    await _notificationRepository.checkNotify().then((value) {
      setCheckNotification(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setCheckNotification(ApiResponse.error(error.toString()));
    });
  }
}
