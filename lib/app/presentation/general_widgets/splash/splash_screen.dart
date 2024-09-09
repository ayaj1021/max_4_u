import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/core/build_context_extension.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_screen.dart';

import 'package:max_4_u/app/styles/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // getNames() async {
  //   final id = await SecureStorage().getEncryptedID();
  //   print('this is user id: $id');
  //   setState(() {
  //     userId = id;
  //   });
  // }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      context.pushReplacementNamed(OnboardScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.scaffoldBgColor,
      ),
      child: Image.asset('assets/logo/max4u_logo.png'),
    );
  }
}
