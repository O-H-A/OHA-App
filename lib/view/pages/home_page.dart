import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/view/pages/home/tab/home_tab.dart';
import 'package:oha/view/pages/home/tab/image_video_tab.dart';
import 'package:oha/view/pages/home/tab/now_weather_tab.dart';
import 'package:oha/view/pages/home/tab/popularity_tab.dart';

import '../../statics/images.dart';
import '../../statics/strings.dart';

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

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
        title: Row(
          children: const [
            Text(
              "논현동",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Icon(Icons.expand_more, color: Colors.black),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
            child: SvgPicture.asset(Images.notification),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            _buildTabBarWidget(),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const <Widget>[
                  HomeTab(),
                  PopularityTab(),
                  ImageVideoTab(),
                  NowWeatherTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
