import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/more_dialog.dart';
import 'package:oha/view/widgets/report_dialog.dart';

class CategoryDetailAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CategoryDetailAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: Colors.black,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
          child: IconButton(
            onPressed: () {
              MoreDialog.show(context);
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
