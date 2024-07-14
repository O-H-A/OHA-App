
import 'package:flutter/material.dart';
import 'package:oha/view_model/notification_view_model.dart';
import 'package:provider/provider.dart';

import '../../../statics/strings.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationViewModel _notificationViewModel = NotificationViewModel();

  @override
  void initState() {
    super.initState();

    _notificationViewModel = Provider.of<NotificationViewModel>(context, listen: false);

    Map<String, dynamic> sendData = {
      Strings.offsetKey: '0',
      Strings.limitKey: '50',
    };

    _notificationViewModel.getNotification(sendData);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
