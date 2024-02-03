import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oha/view/pages/agreements/agreements_page.dart';
import 'package:oha/view/pages/diary/diary_register_page.dart';
import 'package:oha/view/pages/home_page.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';
import 'package:oha/view/pages/splash_page.dart';
import 'package:oha/view/pages/upload/upload_agreements_page.dart';
import 'package:oha/view/pages/upload/upload_page.dart';

import 'app.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LocationSettingPage(),
      ),
    );
  }
}
