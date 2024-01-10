import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/agreements/agreements_app_bar_widget.dart';

import '../../../statics/strings.dart';

class PrivacyAgreementsPage extends StatelessWidget {
  const PrivacyAgreementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AgreementsAppBarWidget(title: Strings.termsOfUse),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              const Text(
                Strings.privacyAgreementGuide,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}