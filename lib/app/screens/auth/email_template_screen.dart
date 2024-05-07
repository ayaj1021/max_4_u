import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/auth/reset_code_screen.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';

class EmailTemplate extends StatefulWidget {
  const EmailTemplate({super.key});

  @override
  State<EmailTemplate> createState() => _EmailTemplateState();
}

class _EmailTemplateState extends State<EmailTemplate> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      nextScreenReplace(context, const ResetCodeScreen());
     });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(
          'Email Template',
          style: AppTextStyles.font20,
        ),
      )),
    );
  }
}
