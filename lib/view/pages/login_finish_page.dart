import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/images.dart';

import '../../app.dart';

class LoginFinishPage extends StatelessWidget {
  const LoginFinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 3)).then((_) async {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const App()),
      );
    });
    return Scaffold(
      body: SvgPicture.asset(
        Images.loginFinishBg,
        fit: BoxFit.cover,
      ),
    );
  }
}
