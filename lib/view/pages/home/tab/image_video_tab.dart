import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';

class ImageVideoTab extends StatefulWidget {
  const ImageVideoTab({super.key});

  @override
  State<ImageVideoTab> createState() => _ImageVideoTabState();
}

Widget _buildCategoryWidget(int index) {
  switch (index) {  
    case 0:
      return SvgPicture.asset(Images.cloudCategory);
    case 1:
      return SvgPicture.asset(Images.moonCategory);
    case 2:
      return SvgPicture.asset(Images.rainbowCategory);
    case 3:
      return SvgPicture.asset(Images.sunsetSunriseCategory);
    case 4:
      return SvgPicture.asset(Images.nightSkyCategory);
    case 5:
      return SvgPicture.asset(Images.sunnyCategory);

    default:
      return Container();
  }
}

Widget _buildCategoryTextWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
    child: const Text(
      Strings.category,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w600,
          fontSize: 20),
    ),
  );
}

class _ImageVideoTabState extends State<ImageVideoTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCategoryTextWidget(),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenUtil().setWidth(12.0),
                crossAxisSpacing: ScreenUtil().setHeight(12.0),
              ),
              itemBuilder: (context, index) {
                return _buildCategoryWidget(index);
              },
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
