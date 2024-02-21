import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oha/utils/secret_key.dart';
import 'package:oha/vidw_model/location_view_model.dart';
import 'package:oha/vidw_model/login_view_model.dart';
import 'package:oha/vidw_model/weather_view_model.dart';
import 'package:oha/view/pages/agreements/agreements_page.dart';
import 'package:oha/view/pages/diary/diary_register_page.dart';
import 'package:oha/view/pages/home/category/category_detail_page.dart';
import 'package:oha/view/pages/home/category/category_page.dart';
import 'package:oha/view/pages/home_page.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';
import 'package:oha/view/pages/location/map_setting_page.dart';
import 'package:oha/view/pages/login_page.dart';
import 'package:oha/view/pages/mypage/profile_edit_page.dart';
import 'package:oha/view/pages/splash_page.dart';
import 'package:oha/view/pages/upload/upload_agreements_page.dart';
import 'package:oha/view/pages/upload/upload_page.dart';
import 'package:oha/view/pages/upload/upload_write_page.dart';
import 'package:provider/provider.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NaverMapSdk.instance.initialize(
    clientId: SecretKey.naverMapClientId,
    //FonAuthFailed: (ex) =>
  );

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 840),
        builder: (BuildContext context, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const ProfileEditPage(),
        ),
      ),
    );
  }
}
