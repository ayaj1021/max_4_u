import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/screens/auth/verfication_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Max4u!',
                style: AppTextStyles.font20,
              ),
              verticalSpace(12),
              Text(
                'Input your phone number to get started',
                style: AppTextStyles.font14
                    .copyWith(color: const Color(0xff475569)),
              ),
              verticalSpace(24),
              TextInputField(
                controller: _phoneEmailController,
                labelText: 'Phone number',
              ),
              verticalSpace(32),
               ButtonWidget(
                onTap: () => nextScreen(context, const VerificationScreen()),
                text: 'Continue',
              ),
              verticalSpace(442),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'Already a member ',
                      style: AppTextStyles.font14
                          .copyWith(color: AppColors.blackColor),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreen(context, const LoginScreen());
                            },
                          text: 'Log in',
                          style: AppTextStyles.font14
                              .copyWith(color: AppColors.secondaryColor),
                        )
                      ]),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
