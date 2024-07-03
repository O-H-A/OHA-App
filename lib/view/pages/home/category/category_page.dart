import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/view/pages/home/category/category_grid_widget.dart';

import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../widgets/feed_widget.dart';

enum ViewType {
  gridView,
  listView,
}

class CategoryPage extends StatefulWidget {
  final int categoryIndex;

  const CategoryPage({Key? key, required this.categoryIndex}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  ViewType viewType = ViewType.gridView;

  // Test
  List<String> imageS = [];

  late TabController tabController = TabController(
    length: 6,
    vsync: this,
    initialIndex: widget.categoryIndex,
    animationDuration: const Duration(milliseconds: 300),
  );

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
    imageS?.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU");
  }

  Widget _buildTabBarWidget() {
    double tabWidth = ScreenUtil().setWidth(390.0) / 6.0;
    return TabBar(
      labelPadding:
          EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.0)),
      controller: tabController,
      isScrollable: true,
      tabs: <Widget>[
        SizedBox(width: tabWidth, child: const Tab(text: Strings.cloud)),
        SizedBox(width: tabWidth, child: const Tab(text: Strings.moon)),
        SizedBox(width: tabWidth, child: const Tab(text: Strings.rainbow)),
        SizedBox(
            width: tabWidth, child: const Tab(text: Strings.sunsetSunrise)),
        SizedBox(width: tabWidth, child: const Tab(text: Strings.nightSky)),
        SizedBox(width: tabWidth, child: const Tab(text: Strings.sunnySky)),
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
        fontWeight: FontWeight.w700,
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().statusBarHeight),
            _buildTabBarWidget(),
            SizedBox(height: ScreenUtil().setHeight(34.0)),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        viewType = ViewType.gridView;
                      });
                    },
                    child: (viewType == ViewType.gridView)
                        ? SvgPicture.asset(Images.viewGridEnable)
                        : SvgPicture.asset(Images.viewGridDisable)),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        viewType = ViewType.listView;
                      });
                    },
                    child: (viewType == ViewType.listView)
                        ? SvgPicture.asset(Images.viewListEnable)
                        : SvgPicture.asset(Images.viewListDisable)),
              ],
            ),
            (viewType == ViewType.gridView)
                ? CategoryGridWidget(imageList: imageS)
                : const FeedWidget(
                  // Test
                    postId: 0,
                    nickName: "고독한 사진작가",
                    locationInfo: "2023년 10월 21일 논현동 거리",
                    likesCount: 3,
                    commentCount: 0,
                    isLike: false,
                    description:
                        "지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요! 지금 노을이 너무 이뻐요!",
                    hashTag: [
                      "구름",
                      "같은 하늘",
                      "노을",
                      "구름",
                      "같은 하늘",
                      "노을",
                      "구름",
                      "같은 하늘",
                      "노을"
                    ],
                    imageUrl: '',
                  ),
          ],
        ),
      ),
    );
  }
}
