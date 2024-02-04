import 'package:flutter/material.dart';

class LocationAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final IconData backIcon;

  const LocationAppBarWidget({Key? key, required this.title, required this.backIcon}) : super(key: key);

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
        onPressed: () {},
        icon: Icon(
          backIcon,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
