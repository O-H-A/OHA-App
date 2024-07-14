class NotificationModel {
  int statusCode;
  String message;
  List<NotificationData> data;

  NotificationModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: List<NotificationData>.from(
          json['data'].map((item) => NotificationData.fromJson(item))),
    );
  }
}

class NotificationData {
  int notificationId;
  int userId;
  String notificationCode;
  List<Message> message;
  bool isRead;
  int? entryId;
  String? entryType;
  String regDtm;
  String? thumbnailUrl;
  String? profileUrl;

  NotificationData({
    required this.notificationId,
    required this.userId,
    required this.notificationCode,
    required this.message,
    required this.isRead,
    this.entryId,
    this.entryType,
    required this.regDtm,
    this.thumbnailUrl,
    this.profileUrl,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      notificationId: json['notification_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      notificationCode: json['notification_code'] ?? '',
      message: List<Message>.from(
          json['message'].map((item) => Message.fromJson(item)) ?? {}),
      isRead: json['is_read'] ?? false,
      entryId: json['entry_id'],
      entryType: json['entry_type'],
      regDtm: json['reg_dtm'] ?? '',
      thumbnailUrl: json['thumbnail_url'],
      profileUrl: json['profile_url'],
    );
  }
}

class Message {
  String text;
  String type;

  Message({
    required this.text,
    required this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] ?? '',
      type: json['type'] ?? '',
    );
  }
}