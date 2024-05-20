import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Set up your profile',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(12),
                  Text(
                    'Input your details to complete your registration',
                    style: AppTextStyles.font14
                        .copyWith(color: const Color(0xff475569)),
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: authProv.firstNameController,
                    labelText: 'First name',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: authProv.lastNameController,
                    labelText: 'Last name',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: authProv.emailController,
                    labelText: 'Email',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    obscure: obscure.isObscure,
                    controller: authProv.passwordController,
                    labelText: 'Password',
                    suffixIcon: obscure.isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTap: () {
                      obscure.changeObscure();
                    },
                  ),
                  verticalSpace(24),
                  TextInputField(
                    obscure: obscure.isObscure,
                    controller: authProv.confirmPasswordController,
                    labelText: 'Confirm password',
                    suffixIcon: obscure.isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTap: () {
                      obscure.changeObscure();
                    },
                  ),
                  verticalSpace(28),
                  RichText(
                    text: TextSpan(
                        text: 'By signing up you agree with our ',
                        style: AppTextStyles.font14
                            .copyWith(color: AppColors.blackColor),
                        children: [
                          TextSpan(
                            text: 'Terms of Service ',
                            style: AppTextStyles.font14.copyWith(
                                color: AppColors.secondaryColor,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                            text: '& ',
                            style: AppTextStyles.font14
                                .copyWith(color: AppColors.blackColor),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.font14.copyWith(
                                color: AppColors.secondaryColor,
                                decoration: TextDecoration.underline),
                          ),
                        ]),
                  ),
                  verticalSpace(32),
                  ButtonWidget(
                    onTap: () async {
                      if (authProv.firstNameController.text.isEmpty || authProv.lastNameController.text.isEmpty || authProv.emailController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      await authProv.registerUser();
                      if (authProv.state == ViewState.Error &&
                          context.mounted) {
                        showMessage(context, authProv.message);
                        return;
                      }

                      if (authProv.state == ViewState.Success &&
                          context.mounted) {
                        showMessage(context, authProv.message);

                        nextScreen(context, const DashBoardScreen());
                      }
                    },
                    text: 'Sign up',
                  ),
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
