import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/notification/notification_page.dart';
import 'package:oha/view/widgets/button_image.dart';
import 'package:oha/view_model/location_view_model.dart';
import 'package:oha/view_model/notification_view_model.dart';
import 'package:oha/view/pages/home/tab/home_tab.dart';
import 'package:oha/view/pages/home/tab/image_video_tab.dart';
import 'package:oha/view/pages/home/tab/now_weather_tab.dart';
import 'package:oha/view/pages/home/tab/popularity_tab.dart';
import 'package:provider/provider.dart';

import '../../statics/images.dart';
import '../../statics/strings.dart';
import '../widgets/main_weather_widget.dart';
import 'location/location_setting_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 0,
    animationDuration: const Duration(milliseconds: 300),
  );

  NotificationViewModel _notificationViewModel = NotificationViewModel();

  @override
  void initState() {
    _notificationViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);

    _notificationViewModel.checkNotification();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _navigateToNotificationPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  Widget _buildTabBarWidget() {
    return TabBar(
      labelPadding:
          EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(1.0)),
      controller: tabController,
      tabs: const <Widget>[
        Tab(text: Strings.home),
        Tab(text: Strings.popularity),
        Tab(text: Strings.imageVideo),
        Tab(text: Strings.nowWeather),
      ],
      labelColor: const Color(0xFF333333),
      labelStyle: const TextStyle(
        fontFamily: "Pretendard",
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelColor: const Color(0xFF444444),
      unselectedLabelStyle: const TextStyle(
        fontFamily: "Pretendard",
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      overlayColor: const MaterialStatePropertyAll(
        Colors.white,
      ),
      indicatorColor: Colors.black,
      indicatorWeight: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: ScreenUtil().setWidth(22.0),
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              builder: (BuildContext context) {
                return LocationSettingBottomSheet();
              },
            );
          },
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  return Text(
                    Provider.of<LocationViewModel>(context).getDefaultLocation,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  );
                },
              ),
              Icon(Icons.expand_more, color: Colors.black),
            ],
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
              child: ButtonImage(
                  imagePath: (_notificationViewModel
                              .checkNotificationData.data?.statusCode ==
                          200)
                      ? Images.newNotification
                      : Images.notification,
                  callback: _navigateToNotificationPage)),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: const FlexibleSpaceBar(
                background: Column(
                  children: [
                    Expanded(child: MainWeatherWidget()),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(48.0),
                child: Container(
                  color: Colors.transparent,
                  child: TabBar(
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(1.0)),
                    controller: tabController,
                    tabs: const <Widget>[
                      Tab(text: Strings.home),
                      Tab(text: Strings.popularity),
                      Tab(text: Strings.imageVideo),
                      Tab(text: Strings.nowWeather),
                    ],
                    labelColor: const Color(0xFF333333),
                    labelStyle: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelColor: const Color(0xFF444444),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overlayColor: const MaterialStatePropertyAll(
                      Colors.white,
                    ),
                    indicatorColor: Colors.black,
                    indicatorWeight: 2,
                    dividerColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const <Widget>[
            HomeTab(),
            PopularityTab(),
            ImageVideoTab(),
            NowWeatherTab(),
          ],
        ),
      ),
    );
  }
}
