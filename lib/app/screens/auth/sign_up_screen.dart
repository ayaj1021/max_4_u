import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/screens/auth/verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneController = TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProviderImpl, ObscureTextProvider>(
        builder: (context, stateModel, obscure, _) {
      return BusyOverlay(
        show: stateModel.state == ViewState.Busy,
        title: stateModel.message,
        child: Scaffold(
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
                    controller: phoneController,
                    labelText: 'Phone number',
                    textInputType: TextInputType.number,
                  ),
                  verticalSpace(32),
                  ButtonWidget(
                    onTap: () async {
                      if (phoneController.text.isEmpty) {
                        showMessage(context, 'Phone number is required',
                            isError: true);
                        return;
                      }

                      await stateModel.signUp(
                          phoneNumber: phoneController.text.trim());
                      if (stateModel.state == ViewState.Error &&
                          context.mounted) {
                        showMessage(context, stateModel.message);
                        return;
                      }

                      if (stateModel.state == ViewState.Success &&
                          context.mounted) {
                        showMessage(context, stateModel.message);

                        nextScreen(
                            context,
                            VerificationScreen(
                              phoneNumber: stateModel.phoneController.text,
                            ));
                      }
                    },
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
        ),
      );
    });
  }
}
