import 'dart:convert';

import 'package:oha/models/notification/notification_model.dart';

import '../models/notification/new_notification_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class NotificationRepository {
  Future<NotificationModel> notify(Map<String, dynamic> queryParams) async {
    try {
      dynamic response = await NetworkManager.instance
          .getWithQuery(ApiUrl.notify, queryParams);
      return NotificationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<NewNotificationModel> checkNotify() async {
    try {
      dynamic response = await NetworkManager.instance
          .get(ApiUrl.notifyCheck);
      return NewNotificationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
