import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/button_icon.dart';
import 'package:oha/view/widgets/more_dialog.dart';

class CategoryDetailAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String imageUrl;

  const CategoryDetailAppBarWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.black,
      elevation: 0,
      leading: ButtonIcon(
          icon: Icons.arrow_back_ios,
          iconColor: Colors.white,
          callback: () => Navigator.pop(context)),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
          child: IconButton(
            onPressed: () {
              MoreDialog.show(context, imageUrl);
            },
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
