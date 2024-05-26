import 'package:flutter/material.dart';

import 'package:max_4_u/app/screens/auth/forgot_password_screen1.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class ForgotPasswordScreen2 extends StatefulWidget {
  const ForgotPasswordScreen2({super.key});

  @override
  State<ForgotPasswordScreen2> createState() => _ForgotPasswordScreen2State();
}

class _ForgotPasswordScreen2State extends State<ForgotPasswordScreen2> {
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 52),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BackArrowButton(
                onTap: () => Navigator.pop(context),
              ),
              verticalSpace(26),
              const Text(
                'Forgot your password?',
                style: AppTextStyles.font20,
              ),
              verticalSpace(12),
              Text(
                'Enter the number associated with this account to get a code to reset your password',
                style: AppTextStyles.font14
                    .copyWith(color: const Color(0xff475569)),
              ),
              verticalSpace(24),
              TextInputField(
                controller: _phoneController,
                labelText: 'Phone number',
              ),
              verticalSpace(40),
              ButtonWidget(
                text: 'Send code',
                onTap: () {}
                // nextScreen(context, const EmailTemplate()),
              ),
              verticalSpace(20),
              GestureDetector(

                onTap: () => nextScreen(context, const ForgotPasswordScreen1()),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      color: AppColors.primaryColor,
                    ),
                    horizontalSpace(15),
                    Text(
                      'Use email instead',
                      style: AppTextStyles.font14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
