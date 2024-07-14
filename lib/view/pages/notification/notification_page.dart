import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/widgets/back_app_bar.dart';
import 'package:oha/view/widgets/loading_widget.dart';
import 'package:oha/view_model/notification_view_model.dart';
import 'package:provider/provider.dart';
import '../error_page.dart';
import '../../../models/notification/notification_model.dart';
import '../../../network/api_response.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  Widget _buildDefaultProfile() {
    return Container(
      width: ScreenUtil().setWidth(28.0),
      height: ScreenUtil().setHeight(28.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: SvgPicture.asset(Images.defaultProfile),
      ),
    );
  }

  Widget _buildNotificationWidget(NotificationData notification) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: SizedBox(
        width: double.infinity,
        height: ScreenUtil().setHeight(82.0),
        child: Row(
          children: [
            notification.profileUrl != null && notification.profileUrl!.isNotEmpty
                ? Image.network(notification.profileUrl!)
                : _buildDefaultProfile(),
            SizedBox(width: ScreenUtil().setWidth(15.0)),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: notification.message.map((m) {
                    return TextSpan(
                      text: m.text,
                      style: TextStyle(
                        fontWeight: m.type == 'bold'
                            ? FontWeight.w700
                            : FontWeight.w400,
                        color: const Color(UserColors.ui01),
                        fontFamily: "Pretendard",
                        fontSize: ScreenUtil().setSp(13.0),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(width: ScreenUtil().setWidth(10.0)),
            if (notification.thumbnailUrl != null && notification.thumbnailUrl!.isNotEmpty)
              Image.network(
                notification.thumbnailUrl!,
                width: ScreenUtil().setWidth(50.0),
                height: ScreenUtil().setHeight(50.0),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(22.0)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(14.0),
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Map<String, List<NotificationData>> _groupNotificationsByDate(
      List<NotificationData> notifications) {
    Map<String, List<NotificationData>> groupedNotifications = {};
    DateTime now = DateTime.now();
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    for (var notification in notifications) {
      DateTime notificationDate = DateTime.parse(notification.regDtm);
      String dateKey;

      if (dateFormat.format(notificationDate) == dateFormat.format(now)) {
        dateKey = Strings.today;
      } else if (dateFormat.format(notificationDate) ==
          dateFormat.format(now.subtract(const Duration(days: 1)))) {
        dateKey = Strings.yesterDay;
      } else {
        int difference = now.difference(notificationDate).inDays;
        if (difference <= 7) {
          difference += 1;
          dateKey = '$difference일 전';
        } else {
          continue;
        }
      }

      if (groupedNotifications[dateKey] == null) {
        groupedNotifications[dateKey] = [];
      }
      groupedNotifications[dateKey]!.add(notification);
    }

    return groupedNotifications;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationViewModel()..getNotification({}),
      child: Scaffold(
        appBar: const BackAppBar(title: Strings.notification),
        body: Consumer<NotificationViewModel>(
          builder: (context, notificationViewModel, child) {
            if (notificationViewModel.notificationsData.status ==
                Status.loading) {
              return const Center(child: LoadingWidget());
            } else if (notificationViewModel.notificationsData.status ==
                Status.error) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ErrorPage(
                      isNetworkError: false,
                      onRetry: () {
                        notificationViewModel.getNotification({});
                      },
                    ),
                  ),
                );
              });
              return Container();
            } else if (notificationViewModel.notificationsData.status ==
                Status.complete) {
              final notifications =
                  notificationViewModel.notificationsData.data?.data ?? [];
              Map<String, List<NotificationData>> groupedNotifications =
                  _groupNotificationsByDate(notifications);

              return ListView.builder(
                itemCount: groupedNotifications.length,
                itemBuilder: (context, index) {
                  String dateKey = groupedNotifications.keys.elementAt(index);
                  List<NotificationData> dateNotifications =
                      groupedNotifications[dateKey]!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: ScreenUtil().setHeight(15.0)),
                      _buildDateHeader(dateKey),
                      ...dateNotifications
                          .map((notification) =>
                              _buildNotificationWidget(notification))
                          .toList(),
                    ],
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
