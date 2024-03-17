import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oha/network/api_url.dart';
import 'package:oha/network/network_manager.dart';
import 'package:oha/view/pages/agreements/agreements_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app.dart';
import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';
import '../../vidw_model/login_view_model.dart';

enum LoginType {
  kakao,
  apple,
  google,
  naver,
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _storage = FlutterSecureStorage();
  String? _loginInfo = "";

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getLoginStorage();
    });
  }

  _getLoginStorage() async {
    _loginInfo = await _storage.read(key: 'login');

    if (_loginInfo != null) {
    } else {
    }
  }

  Future<void> _login(
    BuildContext context,
    LoginViewModel data,
    LoginType type,
  ) async {
    InAppWebViewController? webViewCtrl;
    try {
      final navigator = Navigator.of(context);

      await navigator.push(
        MaterialPageRoute(
          builder: (context) => InAppWebView(
            onWebViewCreated: (controller) {
              webViewCtrl = controller;
            },
            initialUrlRequest: URLRequest(url: Uri.parse(_getLoginUrl(type))),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(),
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
            ),
            onLoadStop: (controller, url) async {
              String javascriptCode = 'document.body.innerHTML';
              final result =
                  await webViewCtrl?.evaluateJavascript(source: javascriptCode);

              if (result != null && result.isNotEmpty) {
                String cleanedResult =
                    result.replaceAll(RegExp(r'<[^>]*>'), '');

                try {
                  Map<String, dynamic> jsonResult = json.decode(cleanedResult);
                  data.setLoginData(json.encode(jsonResult));

                  if (data.loginData.data?.data.type == "new") {
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => const AgreementsPage(),
                      ),
                    );
                  } else {
                    navigator.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const App()),
                      (Route<dynamic> route) => false,
                    );
                  }

                  await _storage.write(
                    key: 'login',
                    value: "true",
                  );

                  await webViewCtrl?.loadUrl(
                    urlRequest: URLRequest(url: Uri.parse("about:blank")),
                  );
                } catch (e) {
                  print("Error decoding JSON or accessing accessToken: $e");
                  await _storage.write(
                    key: 'login',
                    value: "false",
                  );
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      print("Error during login: $e");
      await _storage.write(
        key: 'login',
        value: "false",
      );
    }
  }

  String _getLoginUrl(LoginType type) {
    switch (type) {
      case LoginType.kakao:
        return ApiUrl.kakaoLogin;
      case LoginType.google:
        return ApiUrl.googleLogin;
      case LoginType.naver:
        return ApiUrl.naverLogin;
      case LoginType.apple:
        return "";
      default:
        throw Exception("Unsupported login type: $type");
    }
  }

  Widget _buildLoginWidget(
      BuildContext context, LoginViewModel data, LoginType type) {
    return GestureDetector(
      onTap: () async {
        await _login(context, data, type);
      },
      child: SvgPicture.asset(
        _getLoginImage(type),
        height: ScreenUtil().setHeight(50.0),
        width: ScreenUtil().setWidth(50.0),
      ),
    );
  }

  String _getLoginImage(LoginType type) {
    switch (type) {
      case LoginType.kakao:
        return Images.loginKakao;
      case LoginType.apple:
        return Images.loginApple;
      case LoginType.google:
        return Images.loginGoogle;
      case LoginType.naver:
        return Images.loginNaver;
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel _loginViewModel = LoginViewModel();
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ScreenUtil().setHeight(86.0)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(22.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    Strings.loginMainText,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(6.0)),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.loginSubText1,
                          style: TextStyle(
                            color: Color(UserColors.primaryColor),
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: Strings.loginSubText2,
                          style: TextStyle(
                            color: Color(UserColors.ui06),
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SvgPicture.asset(Images.loginBg),
          SizedBox(height: ScreenUtil().setHeight(28.0)),
          _buildLoginWidget(context, _loginViewModel, LoginType.kakao),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildLoginWidget(context, _loginViewModel, LoginType.apple),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildLoginWidget(context, _loginViewModel, LoginType.google),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildLoginWidget(context, _loginViewModel, LoginType.naver),
          SizedBox(height: ScreenUtil().setHeight(166.0)),
        ],
      ),
    );
  }
}
