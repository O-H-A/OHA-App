import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/vidw_model/upload_view_model.dart';
import 'package:oha/view/pages/upload/add_keyword_dialog.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../network/api_url.dart';
import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../../utils/secret_key.dart';
import '../../../vidw_model/location_view_model.dart';
import '../../widgets/infinity_button.dart';
import '../../widgets/location_info_dialog.dart';
import '../location/location_setting_page.dart';

import 'package:dio/dio.dart';

import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;

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
  int _categorySelectIndex = 0;
  final _textController = TextEditingController();
  UploadViewModel _uploadViewModel = UploadViewModel();
  LocationViewModel _locationViewModel = LocationViewModel();

  /*
    구름 	CTGR_CLOUD
    달	CTGR_MOON
    무지개	CTGR_RAINBOW
    일몰/일출	CTGR_SUNSET_SUNRISE
    밤하늘	CTGR_NIGHT_SKY
    맑은 하늘	CTGR_CLEAR_SKY
  */

  Map<int, String> categoryMap = {
    0: "CTGR_CLOUD",
    1: "CTGR_MOON",
    2: "CTGR_RAINBOW",
    3: "CTGR_SUNSET_SUNRISE",
    4: "CTGR_NIGHT_SKY",
    5: "CTGR_CLEAR_SKY"
  };

  @override
  void initState() {
    super.initState();

    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen:false);

    Future.delayed(Duration.zero, () {
      _uploadViewModel.getKetwordList.clear();
      _uploadViewModel.setUploadLocation("");

      setState(() {});
    });
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
        text = Strings.sunnySky;
        break;
      default:
        break;
    }

    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        setState(() {
          _categorySelectIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: ScreenUtil().setWidth(8.0)),
        child: Container(
          height: ScreenUtil().setHeight(35.0),
          width: ScreenUtil()
              .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(30.0)),
          decoration: BoxDecoration(
            color: (_categorySelectIndex == index)
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
              color: (_categorySelectIndex == index)
                  ? Colors.white
                  : const Color(UserColors.ui01),
            ),
          ),
        ),
      ),
    );
  }

  void showKeyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddKeywordDialog();
      },
    );
  }

  void getLocationInfo() async {
    Map<String, String?>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSettingPage()),
    );

    if (result != null) {
      String fullAddress = result['fullAddress'] ?? "";

      _uploadViewModel.setUploadLocation(fullAddress);
    } else {
      return;
    }

    showLocationInfoDialog();
  }

  void showLocationInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationInfoDialog();
      },
    );

    setState(() {
      
    });
  }

  Widget _buildKeywordDefaultWidget() {
    String text = Strings.keywordDefault;

    return GestureDetector(
      onTap: () {
        showKeyDialog();
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

  Widget _buildKeywordWidget(String text, int index) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () {
        showKeyDialog();
        setState(() {});
      },
      child: Container(
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
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _uploadViewModel.getKetwordList.removeAt(index);
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

  Widget _buildLocationDefaultWidget(String text) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return GestureDetector(
      onTap: () async {
        getLocationInfo();
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
        getLocationInfo();
      },
      child: Container(
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
          padding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle( 
                    color: Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _uploadViewModel.setUploadLocation("");
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

  Future<void> upload() async {
    String content = _textController.text;
    String selectCategory = categoryMap[_categorySelectIndex] ?? "";
    List<String> keyword = _uploadViewModel.getKetwordList;
    String selectLocationCode = _locationViewModel.getCodeByAddress(_uploadViewModel.getUploadLocation);

    List<String> selectedKeywords = [];
    for (int i = 0; i < min(keyword.length, 3); i++) {
      selectedKeywords.add(keyword[i]);
    }

    Map<String, dynamic> sendData = {
      "content": content,
      "categoryCode": selectCategory,
      "keywords": selectedKeywords,
      "regionCode": selectLocationCode,
      "locationDetail": _uploadViewModel.getUploadLocation,
    };

    try {
      await _uploadViewModel.posting(
          sendData, await widget.selectImage.thumbnailData);
    } catch (error) {
      print('Error uploading: $error');
    }
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
                          itemCount: categoryMap.length,
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
                          _uploadViewModel.getKetwordList.length.toString() +
                              Strings.keywordCount,
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
                    (_uploadViewModel.getKetwordList.isEmpty)
                        ? _buildKeywordDefaultWidget()
                        : SizedBox(
                            height: ScreenUtil().setHeight(35.0),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _uploadViewModel.getKetwordList.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                    width: ScreenUtil().setWidth(8.0));
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return _buildKeywordWidget(
                                    _uploadViewModel.getKetwordList[index],
                                    index);
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
                    (_uploadViewModel.getUploadLocation.isEmpty)
                        ? _buildLocationDefaultWidget("ex) 면목동")
                        : _buildLocationWidget(
                            _uploadViewModel.getUploadLocation),
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
                backgroundColor: (_textController.text.isNotEmpty &&
                        _uploadViewModel.getUploadLocation.isNotEmpty)
                    ? const Color(UserColors.primaryColor)
                    : const Color(UserColors.ui10),
                text: Strings.upload,
                textSize: 16,
                textWeight: FontWeight.w600,
                textColor: (_textController.text.isNotEmpty &&
                        _uploadViewModel.getUploadLocation.isNotEmpty)
                    ? Colors.white
                    : Colors.black,
                callback: upload,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
