import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/agreements/location_agreements_page.dart';
import 'package:oha/view/pages/agreements/privacy_agreements_page.dart';
import 'package:oha/view/pages/agreements/service_agreements_page.dart';

import '../../../statics/strings.dart';
import '../../widgets/back_app_bar.dart';

class TermsAndPolicies extends StatelessWidget {
  const TermsAndPolicies({super.key});

  Widget _buildAgreementWidget(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case Strings.serviceAgreement:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ServiceAgreementsPage()),
            );
            break;

          case Strings.privacyAgreement:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PrivacyAgreementsPage()),
            );
            break;

          case Strings.locationAgreement:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LocationAgreementsPage()),
            );
            break;

          default:
            break;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(
        title: Strings.termsAndPolicies,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            SizedBox(height: ScreenUtil().setHeight(23.0)),
            _buildAgreementWidget(context, Strings.serviceAgreement),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            _buildAgreementWidget(context, Strings.privacyAgreement),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            _buildAgreementWidget(context, Strings.locationAgreement),
          ],
        ),
      ),
    );
  }
}
