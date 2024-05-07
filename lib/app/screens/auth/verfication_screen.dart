import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/auth/registration_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 41),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackArrowButton(
                  onTap: () => Navigator.pop(context),
                ),
                verticalSpace(26),
                const Text(
                  'Verification Code',
                  style: AppTextStyles.font20,
                ),
                verticalSpace(12),
                Text(
                  'Enter the 6-digit code sent to you at “0908169784011”',
                  style: AppTextStyles.font14
                      .copyWith(color: const Color(0xff475569)),
                ),
                verticalSpace(24),
                PinCodeTextField(
                  controller: _otpController,
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                    inactiveColor: AppColors.borderColor,
                    fieldHeight: 48,
                    fieldWidth: 48,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                verticalSpace(40),
                ButtonWidget(
                  text: 'Enter',
                  onTap: () {
                    nextScreen(context, const RegistrationScreen());
                  },
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't get a code? ",
                      style: AppTextStyles.font14,
                    ),
                    horizontalSpace(10),
                    Text(
                      "00:30",
                      style: AppTextStyles.font14
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
