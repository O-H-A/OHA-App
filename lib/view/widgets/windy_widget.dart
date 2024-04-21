import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import '../../../../statics/images.dart';

class WindyWidget extends StatelessWidget {
  final String neighborhood;
  final String temperature;

  const WindyWidget({
    super.key,
    required this.neighborhood,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "현재 $neighborhood은",
                style: const TextStyle(
                    color: Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              Text(
                "$temperature°C",
                style: const TextStyle(
                    color: Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              const Text(
                "바람이 많이 불어요\n외투가 필요한 날씨에요",
                style: TextStyle(
                    color: Color(UserColors.ui04),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ],
          ),
          SvgPicture.asset(Images.cloudyDisable),
        ],
      ),
    );
  }
}
