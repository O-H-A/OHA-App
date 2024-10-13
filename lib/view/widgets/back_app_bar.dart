import 'package:flutter/material.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/view/widgets/button_icon.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final bool isUnderLine;

  const BackAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.isUnderLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w600,
            fontSize: 18),
      ),
      centerTitle: true,
      titleSpacing: 0,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: ButtonIcon(
          icon: Icons.arrow_back_ios,
          iconColor: Colors.black,
          callback: () {
            Navigator.pop(context);
          },
        ),
      ),
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
