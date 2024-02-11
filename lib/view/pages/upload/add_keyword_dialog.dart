import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../widgets/infinity_button.dart';

class AddKeywordDialog extends StatefulWidget {
  const AddKeywordDialog({super.key});

  @override
  State<AddKeywordDialog> createState() => _AddKeywordDialogState();
}

class _AddKeywordDialogState extends State<AddKeywordDialog> {
  final _controller = TextEditingController();
  List<String> _keywordList = [];

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
          Strings.exampleKeyword,
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

  Widget _buildKeywordWidget(String text, int index) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Container(
        height: ScreenUtil().setHeight(35.0),
        width: ScreenUtil()
            .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(55.0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
          border: Border.all(color: const Color(UserColors.ui08)),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Color(UserColors.ui01),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _keywordList.removeAt(index);
                    });
                  },
                  child:
                      const Icon(Icons.cancel, color: Color(UserColors.ui07))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(177.0),
            left: ScreenUtil().setWidth(12.0),
            right: ScreenUtil().setWidth(12.0)),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(347.0),
            color: Colors.white,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(40.0)),
                  const Text(
                    Strings.addKeywordSetting,
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
                          text: Strings.addKeywordGuide1,
                          style: TextStyle(
                              color: Color(UserColors.primaryColor),
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        TextSpan(
                          text: Strings.addKeywordGuide2,
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
                  (_keywordList.isEmpty)
                      ? _buildExampleWidget()
                      : SizedBox(
                          height: ScreenUtil().setHeight(35.0),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _keywordList.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                  width: ScreenUtil().setWidth(8.0));
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return _buildKeywordWidget(
                                  _keywordList[index], index);
                            },
                          ),
                        ),
                  SizedBox(height: ScreenUtil().setHeight(22.0)),
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      controller: _controller,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        color: Color(UserColors.ui01),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(UserColors.ui11),
                        hintText: Strings.uploadWriteHintText,
                        hintStyle: const TextStyle(
                          color: Color(UserColors.ui06),
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(22.0)),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(42.0)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_controller.text.isNotEmpty) {
                            _keywordList.add(_controller.text);
                            _controller.text = "";
                          }
                        });
                      },
                      child: InfinityButton(
                        height: ScreenUtil().setHeight(50.0),
                        radius: ScreenUtil().radius(8.0),
                        backgroundColor: const Color(UserColors.primaryColor),
                        text: Strings.add,
                        textSize: 16,
                        textWeight: FontWeight.w600,
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
