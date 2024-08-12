import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_screen.dart';

import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userId = '';
  String level = '';
  // getNames() async {
  //   final id = await SecureStorage().getEncryptedID();
  //   print('this is user id: $id');
  //   setState(() {
  //     userId = id;
  //   });
  // }

  getUserLevel() async {
    final userLevel = await SecureStorage().getUserLevel();
    print('this is user level: $userLevel');

    setState(() {
      level = userLevel;
    });
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<ReloadUserDataProvider>(context, listen: false)
    //       .reloadUserData();
    // });

  //  getNames();
    getUserLevel();
    // final id = Provider.of<AuthProviderImpl>(context, listen: false).resDataData.userData[0];
    Timer(const Duration(seconds: 3), () async {
      // if (userId.isNotEmpty && level.isNotEmpty) {
      //   nextScreenReplace(context, DashBoardScreen());
      // } else {
      nextScreenReplace(context, const OnboardScreen());
      //}
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
