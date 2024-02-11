import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/upload/add_keyword_dialog.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../app.dart';
import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../widgets/infinity_button.dart';

class UploadWritePage extends StatefulWidget {
  final AssetEntity selectImage;

  const UploadWritePage({
    Key? key,
    required this.selectImage,
  }) : super(key: key);

  @override
  State<UploadWritePage> createState() => _UploadWritePageState();
}

class _UploadWritePageState extends State<UploadWritePage> {
  int _selectIndex = 0;
  final _textController = TextEditingController();
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

  Widget _buildCategoryWidget(int index) {
    String text = "";

    switch (index) {
      case 0:
        text = Strings.cloud;
        break;
      case 1:
        text = Strings.moon;
        break;
      case 2:
        text = Strings.rainbow;
        break;
      case 3:
        text = Strings.sunsetSunrise;
        break;
      case 4:
        text = Strings.nightSky;
        break;
      case 5:
        text = Strings.sunny;
        break;
      default:
        break;
    }

    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(8.0)),
        child: Container(
          height: ScreenUtil().setHeight(35.0),
          width: ScreenUtil()
              .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(30.0)),
          decoration: BoxDecoration(
            color: (_selectIndex == index)
                ? const Color(UserColors.primaryColor)
                : Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
            border: Border.all(color: const Color(UserColors.ui08)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: (_selectIndex == index)
                  ? Colors.white
                  : const Color(UserColors.ui01),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeywordDefaultWidget() {
    String text = Strings.keywordDefault;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddKeywordDialog();
          },
        );
      },
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(8.0)),
        child: Container(
          height: ScreenUtil().setHeight(35.0),
          width: ScreenUtil().setWidth(115.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
            border: Border.all(color: const Color(UserColors.ui08)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(UserColors.ui06),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeywordWidget(String text) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(8.0)),
        child: Container(
          height: ScreenUtil().setHeight(35.0),
          width: ScreenUtil()
              .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(30.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
            border: Border.all(color: const Color(UserColors.ui08)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(UserColors.ui06),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationWidget(String text) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(8.0)),
        child: Container(
          height: ScreenUtil().setHeight(35.0),
          width: ScreenUtil()
              .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(30.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
            border: Border.all(color: const Color(UserColors.ui08)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(UserColors.ui06),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: ScreenUtil().setWidth(22.0),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Text(
              Strings.write,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              color: Colors.black,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const App()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(24.0)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(24.0)),
                      child: SizedBox(
                        width: double.infinity,
                        height: ScreenUtil().setHeight(298.0),
                        child: AssetEntityImage(
                          widget.selectImage,
                          isOriginal: false,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(22.0)),
                    const Text(
                      Strings.write,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(12.0)),
                    SizedBox(
                      height: ScreenUtil().setHeight(136.0),
                      child: TextField(
                        maxLines: null,
                        minLines: null,
                        expands: true,
                        controller: _textController,
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
                    SizedBox(height: ScreenUtil().setHeight(20.0)),
                    const Text(
                      Strings.category,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(22.0)),
                    SizedBox(
                      height: ScreenUtil().setHeight(35.0),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildCategoryWidget(index);
                          }),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(28.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          Strings.keyword,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          _keywordList.length.toString() + Strings.keywordCount,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(12.0)),
                    (_keywordList.isEmpty)
                        ? _buildKeywordDefaultWidget()
                        : SizedBox(
                            height: ScreenUtil().setHeight(35.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _keywordList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildKeywordWidget("가을 하늘");
                              },
                            ),
                          ),
                    SizedBox(height: ScreenUtil().setHeight(22.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          Strings.location,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(12.0)),
                    _buildLocationWidget("ex) 면목동"),
                    SizedBox(height: ScreenUtil().setHeight(49.0)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(23.0),
              ),
              child: InfinityButton(
                height: ScreenUtil().setHeight(50.0),
                radius: ScreenUtil().radius(8.0),
                backgroundColor: const Color(UserColors.ui10),
                text: Strings.upload,
                textSize: 16,
                textWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
