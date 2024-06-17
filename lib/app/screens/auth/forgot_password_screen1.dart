import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/screens/auth/reset_code_screen.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen1 extends StatefulWidget {
  const ForgotPasswordScreen1({super.key});

  @override
  State<ForgotPasswordScreen1> createState() => _ForgotPasswordScreen1State();
}

class _ForgotPasswordScreen1State extends State<ForgotPasswordScreen1> {
  final _emailController= TextEditingController();
  @override
  void dispose() {
   _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderImpl>(
      builder: (context, authProv, _) {
        return BusyOverlay(
             show: authProv.state == ViewState.Busy,
        title: authProv.message,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
                  child:
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    BackArrowButton(
                      onTap: () => Navigator.pop(context),
                    ),
                    verticalSpace(26),
                     Text(
                      'Forgot your password?',
                      style: AppTextStyles.font20,
                    ),
                    verticalSpace(12),
                    Text(
                      'Enter the email associated with this account to get a code to reset your password',
                      style: AppTextStyles.font14
                          .copyWith(color: const Color(0xff475569)),
                    ),
                    verticalSpace(24),
                    TextInputField(
                      controller: _emailController,
                      labelText: 'Email',
                    ),
                    verticalSpace(40),
                    ButtonWidget(
                      text: 'Send code',
                      onTap: ()async {
                          if (_emailController.text.isEmpty) {
                        showMessage(context, 'Email is required',
                            isError: true);
                        return;
                      }

                      await authProv.forgotPassword(email: _emailController.text.trim());
                      if (authProv.state == ViewState.Error &&
                          context.mounted) {
                        showMessage(context, authProv.message);
                        return;
                      }

                      if (authProv.state == ViewState.Success &&
                          context.mounted) {
                        showMessage(context, authProv.message);

                       
                      nextScreen(context, const ResetCodeScreen());
                      }
                      }
                    ),
                    verticalSpace(20),
                    // GestureDetector(
                    //   onTap: () => nextScreen(context, const ForgotPasswordScreen2()),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Icon(
                    //         Icons.phone_android_rounded,
                    //         color: AppColors.primaryColor,
                    //       ),
                    //       horizontalSpace(8),
                    //       Text(
                    //         'Use phone number instead',
                    //         style: AppTextStyles.font14.copyWith(
                    //           color: AppColors.primaryColor,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ]),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
