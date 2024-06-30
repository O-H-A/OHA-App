import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/models/upload/upload_get_model.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/utils/app_initializer.dart';
import 'package:oha/view_model/my_page_view_model.dart';
import 'package:oha/view_model/weather_view_model.dart';
import 'package:oha/view/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../statics/strings.dart';
import '../../view_model/location_view_model.dart';
import '../../view_model/login_view_model.dart';
import '../../view_model/upload_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    AppInitializer.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        Images.splashBg,
        fit: BoxFit.cover,
      ),
    );
  }
}
