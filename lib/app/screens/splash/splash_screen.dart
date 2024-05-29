import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userId = '';

  getNames() async {
    final id = await SecureStorage().getUniqueId();

    setState(() {
      userId = id;
    });
  }

  @override
  void initState() {
    getNames();
    Timer(const Duration(seconds: 3), () async {
      //  ReloadUserDataProvider().reloadUserData();
      if (userId == null) {
        nextScreenReplace(context, const OnboardScreen());
      } else {
        
        nextScreenReplace(context, DashBoardScreen());
      }
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
