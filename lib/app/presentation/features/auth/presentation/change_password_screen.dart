import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/login_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

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
    return Consumer2<AuthProviderImpl, ObscureTextProvider>(
      builder: (context, authProv, obscure, _) {
        return BusyOverlay(
          show: authProv.state == ViewState.Busy,
          title: authProv.message,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BackArrowButton(
                          onTap: () => Navigator.pop(context),
                        ),
                        verticalSpace(26),
                        Text(
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
                          obscure: obscure.isObscure,
                          controller: _newPasswordController,
                          labelText: 'New password',
                          suffixIcon: obscure.isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onTap: () {
                            obscure.changeObscure();
                          },
                        ),
                        verticalSpace(authProv.status == false ? 5 : 0),
                        authProv.status == false
                            ? Text(
                                authProv.wrongPassword,
                                //wrongPassword,
                                style: AppTextStyles.font12.copyWith(
                                  color: Colors.red,
                                ),
                              )
                            : Text(''),
                        verticalSpace(24),
                        TextInputField(
                          obscure: obscure.isObscure,
                          controller: _confirmNewPasswordController,
                          labelText: 'Confirm new password',
                          suffixIcon: obscure.isObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          onTap: () {
                            obscure.changeObscure();
                          },
                        ),
                        verticalSpace(authProv.status == false ? 5 : 0),
                        authProv.status == false
                            ? Text(
                                authProv.wrongPassword,
                                //wrongPassword,
                                style: AppTextStyles.font12.copyWith(
                                  color: Colors.red,
                                ),
                              )
                            : Text(''),
                        verticalSpace(32),
                        ButtonWidget(
                            text: 'Reset password',
                            onTap: () async {
                              if (_newPasswordController.text.isEmpty ||
                                  _confirmNewPasswordController.text.isEmpty) {
                                showMessage(context, 'All fields are required',
                                    isError: true);
                                return;
                              }

                              await authProv.changePassword(
                                  newPassword:
                                      _newPasswordController.text.trim(),
                                  confirmNewPassword:
                                      _confirmNewPasswordController.text
                                          .trim());
                              if (authProv.state == ViewState.Error &&
                                  context.mounted) {
                                showMessage(
                                    context, authProv.message.toString(),
                                    isError: true);
                                return;
                              }

                              if (authProv.state == ViewState.Success &&
                                  context.mounted) {
                                showMessage(context, authProv.message);

                                passwordChangeVerifyAlertBox(context);
                              }
                            }),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
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
                  Text(
                    'Password reset successfully',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(13),
                  Text(
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
