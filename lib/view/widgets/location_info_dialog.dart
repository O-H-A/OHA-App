import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/infinity_button.dart';

import '../../statics/colors.dart';
import '../../statics/strings.dart';

class LocationInfoDialog extends StatefulWidget {
  @override
  _LocationInfoDialogState createState() => _LocationInfoDialogState();
}

class _LocationInfoDialogState extends State<LocationInfoDialog> {
  final _controller = TextEditingController();
  List<String> locationList = [];

  Widget _buildExampleWidget() {
    return Container(
      width: ScreenUtil().setWidth(106.0),
      height: ScreenUtil().setHeight(35.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui08)),
      ),
      child: const Center(
        child: Text(
          Strings.exampleLocation,
          style: TextStyle(
            color: Color(UserColors.ui06),
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationWidget(String location) {
    return Container(
      width: ScreenUtil().setWidth(106.0),
      height: ScreenUtil().setHeight(35.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            location,
            style: const TextStyle(
              color: Color(UserColors.ui01),
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Icon(Icons.cancel, color: Color(UserColors.ui07)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        //width: double.infinity,
        width: ScreenUtil().setWidth(366.0),
        height: ScreenUtil().setHeight(389.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(40.0)),
            const Text(
              Strings.addInputLocation,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(4.0)),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: Strings.addInputLocationGuide1,
                    style: TextStyle(
                        color: Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  TextSpan(
                    text: Strings.addInputLocationGuide2,
                    style: TextStyle(
                        color: Color(UserColors.primaryColor),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  TextSpan(
                    text: Strings.addInputLocationGuide3,
                    style: TextStyle(
                        color: Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            (locationList.isEmpty)
                ? _buildLocationWidget("인천 중구")
                : _buildExampleWidget(),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            TextField(
              controller: _controller,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color(UserColors.ui06),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(UserColors.ui11),
                hintText: Strings.titleHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            InfinityButton(
              height: ScreenUtil().setHeight(50.0),
              radius: ScreenUtil().radius(8.0),
              backgroundColor: const Color(UserColors.primaryColor),
              text: Strings.add,
              textSize: 16,
              textWeight: FontWeight.w600,
              textColor: Colors.white,
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: InfinityButton(
                height: ScreenUtil().setHeight(50.0),
                radius: ScreenUtil().radius(8.0),
                backgroundColor: const Color(UserColors.ui10),
                text: Strings.onlyLocationRegister,
                textSize: 16,
                textWeight: FontWeight.w600,
                textColor: const Color(UserColors.ui01),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
