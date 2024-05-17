import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/auth/forgot_password_screen1.dart';
import 'package:max_4_u/app/screens/auth/sign_up_screen.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneEmailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                'Welcome back',
                style: AppTextStyles.font20,
              ),
              verticalSpace(12),
              Text(
                'Input your details below to continue',
                style: AppTextStyles.font14
                    .copyWith(color: const Color(0xff475569)),
              ),
              verticalSpace(26),
              TextInputField(
                controller: _phoneEmailController,
                labelText: 'Phone number/Email',
                hintText: 'Input your email or phone number',
              ),
              verticalSpace(24),
              TextInputField(
                controller: _passwordController,
                labelText: 'Password',
                suffixIcon: Icons.visibility_outlined,
              ),
              verticalSpace(16),
              GestureDetector(
                onTap: () => nextScreen(context, const ForgotPasswordScreen1()),
                child: Text(
                  'Forgot password?',
                  style: AppTextStyles.font14
                      .copyWith(color: AppColors.secondaryColor),
                ),
              ),
              verticalSpace(32),
              ButtonWidget(
                onTap: () => nextScreen(context, const DashBoardScreen()),
                text: 'Log in',
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.fingerprint_outlined,
                    color: AppColors.primaryColor,
                  ),
                  horizontalSpace(8),
                  Text(
                    'Click to login with fingerprint',
                    style: AppTextStyles.font14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
              verticalSpace(260),
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
                              nextScreen(context, const SignUpScreen());
                            },
                          text: 'Sign up',
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
