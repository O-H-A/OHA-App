import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../widgets/feed_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildTodaySkyText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: const Text(
        Strings.todaySky,
        style: TextStyle(
          fontFamily: "Pretendard",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(UserColors.ui01),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildTodaySkyText(),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          const FeedWidget(
            length: 6,
            nickName: "고독한 사진작가",
            locationInfo: "2023년 10월 21일 논현동 거리",
            likesCount: 3,
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
          ),
        ],
      ),
    );
  }
}
