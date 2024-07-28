import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app.dart';
import '../../../statics/images.dart';
import '../../../utils/app_initializer.dart';

class SignUpCompletePage extends StatefulWidget {
  const SignUpCompletePage({super.key});

  @override
  State<SignUpCompletePage> createState() => _SignUpCompletePageState();
}

class _SignUpCompletePageState extends State<SignUpCompletePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () => AppInitializer.initialize(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SvgPicture.asset(
          Images.signUpComplete,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
