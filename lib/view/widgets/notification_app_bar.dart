import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';

class NotificationAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool isUnderLine;

  const NotificationAppBar({
    Key? key,
    required this.title,
    this.isUnderLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: ScreenUtil().setWidth(22.0),
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w600,
                fontSize: 20),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
          child: SvgPicture.asset(Images.notification),
        ),
      ],
      bottom: isUnderLine
          ? PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: const Color(UserColors.ui10),
                height: 1.0,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
