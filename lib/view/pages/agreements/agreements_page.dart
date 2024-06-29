import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/Colors.dart';
import 'package:oha/view/pages/agreements/location_agreements_page.dart';
import 'package:oha/view/pages/agreements/privacy_agreements_page.dart';
import 'package:oha/view/pages/agreements/service_agreements_page.dart';
import 'package:oha/view/pages/agreements/sign_up_complete_page.dart';
import 'package:oha/view/pages/login_finish_page.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';
import '../../../vidw_model/login_view_model.dart';
import '../../widgets/infinity_button.dart';

class AgreementsPage extends StatefulWidget {
  const AgreementsPage({super.key});

  @override
  State<AgreementsPage> createState() => _AgreementsPageState();
}

class _AgreementsPageState extends State<AgreementsPage> {
  LoginViewModel _loginViewModel = LoginViewModel();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool _allAgreements = false;
  bool _serviceAgreements = false;
  bool _privacyAgreements = false;
  bool _locationAgreements = false;

  @override
  void initState() {
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    super.initState();
  }

  void _termsAgreeComplete() async {
    _loginViewModel.termsAgree();

    await _storage.write(
      key: Strings.loginKey,
      value: "true",
    );

    if (!mounted) return; 

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpCompletePage()),
    );
  }

  Widget _buildAllAgreementsWidget() {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(8.0)),
            color: const Color(UserColors.ui11),
          ),
          child: SizedBox(height: ScreenUtil().setHeight(50.0)),
        ),
        Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(11.0)),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _toggleAgreementState(Strings.allAgreements);
                  },
                  child: SvgPicture.asset(
                      _allAgreements ? Images.check : Images.uncheck)),
              SizedBox(width: ScreenUtil().setWidth(11.0)),
              const Text(
                Strings.allAgreements,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementsWidget(String title, bool isChecked) {
    return GestureDetector(
      onTap: () {
        _showTermsOfUse(title);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _toggleAgreementState(title);
                  },
                  child: SvgPicture.asset(
                      isChecked ? Images.check : Images.uncheck)),
              SizedBox(width: ScreenUtil().setWidth(11.0)),
              Text(
                title,
                style: const TextStyle(
                    color: Color(UserColors.ui04),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
          const Icon(Icons.navigate_next, color: Color(UserColors.ui04)),
        ],
      ),
    );
  }

  void _toggleAgreementState(String title) {
    setState(() {
      switch (title) {
        case Strings.requiredServiceAgreement:
          _serviceAgreements = !_serviceAgreements;
          break;
        case Strings.requiredPrivacyAgreement:
          _privacyAgreements = !_privacyAgreements;
          break;
        case Strings.requiredLocationAgreement:
          _locationAgreements = !_locationAgreements;
          break;
        default:
          _allAgreements = !_allAgreements;
          _serviceAgreements = _allAgreements;
          _privacyAgreements = _allAgreements;
          _locationAgreements = _allAgreements;
          break;
      }
    });
  }

  void _showTermsOfUse(String title) {
    setState(() {
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
        default:
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LocationAgreementsPage()),
          );
          break;
      }
    });
  }

  bool _getAllAgreements() {
    return _serviceAgreements && _privacyAgreements && _locationAgreements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(86.0)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.agreementsMainGuide,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 24),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(4.0)),
                  const Text(
                    Strings.agreementsSubGuide,
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(56.0)),
                  _buildAllAgreementsWidget(),
                  SizedBox(height: ScreenUtil().setHeight(32.0)),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(11.0)),
                    child: Column(
                      children: [
                        _buildAgreementsWidget(
                            Strings.serviceAgreement, _serviceAgreements),
                        SizedBox(height: ScreenUtil().setHeight(14.0)),
                        _buildAgreementsWidget(
                            Strings.privacyAgreement, _privacyAgreements),
                        SizedBox(height: ScreenUtil().setHeight(14.0)),
                        _buildAgreementsWidget(
                            Strings.locationAgreement, _locationAgreements),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(44)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginFinishPage()),
                  );
                },
                child: InfinityButton(
                  height: ScreenUtil().setHeight(50.0),
                  radius: 8.0,
                  backgroundColor: _getAllAgreements()
                      ? const Color(UserColors.primaryColor)
                      : const Color(UserColors.ui10),
                  text: Strings.signUpComplete,
                  textSize: 16,
                  textWeight: FontWeight.w600,
                  textColor: _getAllAgreements()
                      ? Colors.white
                      : const Color(UserColors.ui06),
                  callback: _termsAgreeComplete,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
