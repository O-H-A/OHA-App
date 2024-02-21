import 'package:flutter/material.dart';
import 'package:oha/view/widgets/button_icon.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const BackAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      backgroundColor: Colors.white,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
