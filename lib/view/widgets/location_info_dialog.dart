import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/infinity_button.dart';
import 'package:provider/provider.dart';

import '../../statics/colors.dart';
import '../../statics/strings.dart';
import '../../view_model/upload_view_model.dart';
import 'button_icon.dart';

class LocationInfoDialog extends StatefulWidget {
  @override
  _LocationInfoDialogState createState() => _LocationInfoDialogState();
}

class _LocationInfoDialogState extends State<LocationInfoDialog> {
  final _controller = TextEditingController();
  UploadViewModel _uploadViewModel = UploadViewModel();

  @override
  void initState() {
    super.initState();

    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
  }

  TextSpan _buildTextSpan(String text) {
    return TextSpan(
      text: text,
    );
  }

  TextPainter _getTextPainter(TextSpan textSpan) {
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter;
  }

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
    final textSpan = _buildTextSpan(location);
    final textPainter = _getTextPainter(textSpan);

    return Container(
      height: ScreenUtil().setHeight(35.0),
      width: ScreenUtil()
          .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(75.0)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
        border: Border.all(color: const Color(UserColors.ui08)),
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                location,
                style: const TextStyle(
                  color: Color(UserColors.ui01),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ButtonIcon(
                icon: Icons.cancel,
                iconColor: Color(UserColors.ui07),
                callback: () {
                  setState(() {
                    _uploadViewModel.setUploadLocation("");
                  });
                }),
          ],
        ),
      ),
    );
  }

  void onAddClicked() {
    String location =
        "${_uploadViewModel.getUploadLocation} ${_controller.text}";
    _uploadViewModel.setUploadLocation(location);

    _controller.text = "";
    Navigator.pop(context);
  }

  void onLocationOnlyClicked() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
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
            (_uploadViewModel.getUploadLocation.isEmpty)
                ? _buildExampleWidget()
                : _buildLocationWidget(_uploadViewModel.getUploadLocation),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            TextField(
              controller: _controller,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color(UserColors.ui01),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(UserColors.ui11),
                hintText: Strings.locationHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(
                  color: Color(UserColors.ui06),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
              callback: onAddClicked,
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            InfinityButton(
              height: ScreenUtil().setHeight(50.0),
              radius: ScreenUtil().radius(8.0),
              backgroundColor: const Color(UserColors.ui10),
              text: Strings.onlyLocationRegister,
              textSize: 16,
              textWeight: FontWeight.w600,
              textColor: const Color(UserColors.ui01),
              callback: onLocationOnlyClicked,
            ),
          ],
        ),
      ),
    );
  }
}
