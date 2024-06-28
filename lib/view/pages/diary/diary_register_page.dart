import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/widgets/button_icon.dart';
import 'package:oha/view/widgets/infinity_button.dart';
import 'package:oha/view/widgets/location_info_dialog.dart';

import '../../widgets/user_container.dart';
import '../home/weather/weather_select_dialog.dart';

class DiaryRegisterPage extends StatefulWidget {
  final DateTime selectDate;

  const DiaryRegisterPage({Key? key, required this.selectDate})
      : super(key: key);

  @override
  State<DiaryRegisterPage> createState() => _DiaryRegisterPageState();
}

class _DiaryRegisterPageState extends State<DiaryRegisterPage> {
  final _titleController = TextEditingController();
  final _contentsController = TextEditingController();
  bool _publicStatus = false;
  XFile? uploadImage;
  final ImagePicker picker = ImagePicker();
  String _selectTitle = "";
  String _selectImage = "";

  String _getToday() {
    return DateFormat('yyyy년 MM월 dd일 (E)', 'ko_KR').format(DateTime.now());
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await picker.pickImage(source: imageSource, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        uploadImage = XFile(pickedFile.path);
      });
    }
  }

  Widget _buildPhotoArea() {
    return uploadImage != null
        ? SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(360.0),
            child: Image.file(File(uploadImage!.path)),
          )
        : _buildImageEmptyWidget();
  }

  Widget _buildTitleText() {
    return const Text(
      Strings.inputTitle,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTitleTextField() {
    return TextField(
      controller: _titleController,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: const Color(UserColors.ui06),
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w700,
        fontSize: ScreenUtil().setSp(16.0),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(UserColors.ui11),
        hintText: Strings.hint150,
        hintStyle: TextStyle(
          color: const Color(UserColors.ui06),
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w400,
          fontSize: ScreenUtil().setSp(14.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildImageEmptyWidget() {
    return UserContainer(
      width: double.infinity,
      height: ScreenUtil().setHeight(390.0),
      backgroundColor: const Color(UserColors.ui10),
      borderRadius: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Color(UserColors.ui04)),
          Text(
            Strings.add,
            style: TextStyle(
              color: Color(UserColors.ui06),
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
      callback: () => getImage(ImageSource.gallery),
    );
  }

  Widget _buildEmptyWeatherSelect() {
    return GestureDetector(
      onTap: () async {
        _getWeatherSelect();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
              color: Colors.white,
              border: Border.all(
                color: const Color(UserColors.ui08),
              ),
            ),
            child: SizedBox(
              height: ScreenUtil().setHeight(82.0),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.cloudyDisable),
                SvgPicture.asset(Images.littleCloudyDisable),
                SvgPicture.asset(Images.manyCloudDisable),
                SvgPicture.asset(Images.sunnyDisable),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _getWeatherSelect() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WeatherSelectDialog();
      },
    );

    if (result != null) {
      setState(() {
        _selectTitle = result['title'];
        _selectImage = result['image'];
        // _selectWeatherCode = Strings.weatherCodeMap[_selectTitle] ?? "";
      });
    }
  }

  Widget _buildSelectWeatherTitleText() {
    return const Text(
      Strings.selectWeather,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildSelectWidgetWidget() {
    return GestureDetector(
      onTap: () {
        _getWeatherSelect();
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
              color: Colors.white,
              border: Border.all(
                color: const Color(UserColors.ui08),
              ),
            ),
            child: SizedBox(
              height: ScreenUtil().setHeight(82.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(25.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(_selectImage),
                SizedBox(
                  width: ScreenUtil().setWidth(32.0),
                ),
                Text(
                  _selectTitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentsTitleText() {
    return const Text(
      Strings.inputContents,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildContentsTextField() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(136.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
        color: const Color(UserColors.ui11),
      ),
      child: TextField(
        controller: _contentsController,
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
          hintText: Strings.hint300,
          hintStyle: TextStyle(
            color: const Color(UserColors.ui06),
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w400,
            fontSize: ScreenUtil().setSp(14.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        maxLines: null,
      ),
    );
  }

  Widget _buildPublicTitleText() {
    return const Text(
      Strings.publicStatus,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildPublicButton() {
    return Row(
      children: [
        const Text(
          Strings.public,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        SizedBox(width: ScreenUtil().setWidth(16.0)),
        CupertinoSwitch(
          value: _publicStatus,
          activeColor: const Color(UserColors.primaryColor),
          onChanged: (bool? value) {
            setState(() {
              _publicStatus = value ?? false;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: ScreenUtil().setWidth(22.0),
          title: Container(
            width: ScreenUtil().setWidth(149.0),
            height: ScreenUtil().setHeight(35.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(18.0)),
              color: Colors.white,
              border: Border.all(color: const Color(UserColors.ui08)),
            ),
            child: Center(
              child: Text(
                _getToday(),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(12.0),
                ),
              ),
            ),
          ),
          leading: ButtonIcon(
            icon: Icons.close,
            iconColor: Colors.black,
            callback: () => Navigator.pop(context),
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhotoArea(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(22.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        _buildTitleText(),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        _buildTitleTextField(),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        _buildSelectWeatherTitleText(),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        (_selectTitle == "" || _selectImage == "")
                            ? _buildEmptyWeatherSelect()
                            : _buildSelectWidgetWidget(),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        _buildContentsTitleText(),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        _buildContentsTextField(),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        _buildPublicTitleText(),
                        SizedBox(height: ScreenUtil().setHeight(10.0)),
                        _buildPublicButton(),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LocationInfoDialog();
                                  },
                                );
                              },
                              child: const Text(
                                Strings.location,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Pretendard",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        Container(
                          width: ScreenUtil().setWidth(101.0),
                          height: ScreenUtil().setHeight(35.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().radius(18.0)),
                            color: Colors.white,
                            border:
                                Border.all(color: const Color(UserColors.ui08)),
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
                        ),
                        SizedBox(height: ScreenUtil().setHeight(35.0)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: ScreenUtil().setHeight(23.0),
                left: ScreenUtil().setWidth(22.0),
                right: ScreenUtil().setWidth(22.0)),
            child: InfinityButton(
              height: ScreenUtil().setHeight(50.0),
              radius: ScreenUtil().radius(8.0),
              backgroundColor: const Color(UserColors.ui10),
              text: Strings.register,
              textSize: 16,
              textWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
