import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/widgets/infinity_button.dart';

class DiaryRegisterPage extends StatefulWidget {
  const DiaryRegisterPage({super.key});

  @override
  State<DiaryRegisterPage> createState() => _DiaryRegisterPageState();
}

class _DiaryRegisterPageState extends State<DiaryRegisterPage> {
  final _titleController = TextEditingController();
  final _contentsController = TextEditingController();
  bool _publicStatus = false;

  String _getToday() {
    return DateFormat('yyyy년 MM월 dd일 (E)', 'ko_KR').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: ScreenUtil().setWidth(22.0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.close, color: Colors.black),
            Container(
              width: ScreenUtil().setWidth(129.0),
              height: ScreenUtil().setHeight(25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(18.0)),
                color: Colors.white,
                border: Border.all(color: const Color(UserColors.ui08)),
              ),
              child: Center(
                child: Text(
                  _getToday(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Icon(Icons.done, color: Colors.black),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(390.0),
                    color: const Color(UserColors.ui10),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(22.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        const Text(
                          Strings.inputTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        TextField(
                          controller: _titleController,
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
                        const Text(
                          Strings.selectWeather,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ScreenUtil().radius(10.0)),
                                color: Colors.white,
                              ),
                              child: SizedBox(
                                height: ScreenUtil().setHeight(82.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(25.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Images.litteCloudIcon),
                                  SvgPicture.asset(Images.cloudyIcon),
                                  SvgPicture.asset(Images.cloudyIcon),
                                  SvgPicture.asset(Images.cloudyIcon),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        const Text(
                          Strings.inputContents,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(12.0)),
                        Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(136.0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(ScreenUtil().radius(8.0)),
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
                              hintText: Strings.titleHintText,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        const Text(
                          Strings.publicStatus,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10.0)),
                        Row(
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
                        ),
                        SizedBox(height: ScreenUtil().setHeight(22.0)),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
