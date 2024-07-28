import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../category/category_page.dart';

class ImageVideoTab extends StatefulWidget {
  const ImageVideoTab({super.key});

  @override
  State<ImageVideoTab> createState() => _ImageVideoTabState();
}

Widget _buildCategoryWidget(int index, Function(int) onTap) {
  final categoryIcons = [
    Images.cloudCategory,
    Images.moonCategory,
    Images.rainbowCategory,
    Images.sunsetSunriseCategory,
    Images.nightSkyCategory,
    Images.sunnyCategory,
  ];

  return GestureDetector(
    onTap: () => onTap(index),
    child: SvgPicture.asset(categoryIcons[index]),
  );
}

Widget _buildCategoryTextWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
    child: Text(
      Strings.category,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w600,
          fontSize: ScreenUtil().setSp(20.0)),
    ),
  );
}

class _ImageVideoTabState extends State<ImageVideoTab> {
  void _navigateToCategoryPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPage(categoryIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryTextWidget(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(12.0)),
              child: Column(
                children: [
                  _buildRow(0),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _buildRow(2),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _buildRow(4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(int startIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCategoryWidget(startIndex, _navigateToCategoryPage),
        if (startIndex + 1 < 6)
          _buildCategoryWidget(startIndex + 1, _navigateToCategoryPage),
      ],
    );
  }
}
