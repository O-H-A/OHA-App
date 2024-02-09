import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:oha/view/pages/home/category/category_feed_widget.dart';

import 'category_detail_app_bar_Widget.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({super.key});

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CategoryDetailAppBarWidget(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CategoryFeedWidget(
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
