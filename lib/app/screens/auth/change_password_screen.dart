import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 92),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              BackArrowButton(
                onTap: () => Navigator.pop(context),
              ),
              verticalSpace(26),
              const Text(
                'Reset password?',
                style: AppTextStyles.font20,
              ),
              verticalSpace(12),
              Text(
                'Enter your new password',
                style: AppTextStyles.font14
                    .copyWith(color: const Color(0xff475569)),
              ),
              verticalSpace(24),
              TextInputField(
                controller: _newPasswordController,
                labelText: 'New password',
              ),
              verticalSpace(24),
              TextInputField(
                controller: _confirmNewPasswordController,
                labelText: 'Confirm new password',
              ),
              verticalSpace(32),
              ButtonWidget(
                  text: 'Reset password',
                  onTap: () {
                    passwordChangeVerifyAlertBox(context);
                  }),
            ]),
          ),
        ),
      ),
    );
  }

  Future<dynamic> passwordChangeVerifyAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 17),
              height: 293.h,
              width: 343.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 67,
                    width: 67,
                    child: Image.asset('assets/images/verify_image.png'),
                  ),
                  verticalSpace(28),
                  const Text(
                    'Password reset successfully',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(13),
                  const Text(
                    'Log in to access your account',
                    style: AppTextStyles.font14,
                  ),
                  verticalSpace(37),
                  SizedBox(
                    height: 48,
                    width: 210.w,
                    child: ButtonWidget(
                      text: 'Login',
                      onTap: () => nextScreen(context, const LoginScreen()),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
