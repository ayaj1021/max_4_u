import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
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

class AddCustomerRegScreen extends StatefulWidget {
  const AddCustomerRegScreen({super.key});

  @override
  State<AddCustomerRegScreen> createState() => _AddCustomerRegScreenState();
}

class _AddCustomerRegScreenState extends State<AddCustomerRegScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AddCustomerProvider, ObscureTextProvider>(
        builder: (context, addCustomer, obscure, _) {
      return BusyOverlay(
        show: addCustomer.state == ViewState.Busy,
        title: addCustomer.message,
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
                    controller: firstNameController,
                    labelText: 'First name',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: lastNameController,
                    labelText: 'Last name',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: emailController,
                    labelText: 'Email',
                  ),
                  verticalSpace(addCustomer.status == false ? 5 : 0),
                  addCustomer.status == false
                      ? Text(
                          addCustomer.existEmail,
                          //existEmail,
                          style: AppTextStyles.font12.copyWith(
                            color: Colors.red,
                          ),
                        )
                      : Text(''),
                  verticalSpace(24),
                  TextInputField(
                    obscure: obscure.isObscure,
                    controller: passwordController,
                    labelText: 'Password',
                    suffixIcon: obscure.isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTap: () {
                      obscure.changeObscure();
                    },
                  ),
                  addCustomer.status == false
                      ? Text(
                          addCustomer.wrongPassword,

                          //wrongPassword,
                          style: AppTextStyles.font12.copyWith(
                            color: Colors.red,
                          ),
                        )
                      : Text(''),
                  verticalSpace(24),
                  TextInputField(
                    obscure: obscure.isObscure,
                    controller: confirmPasswordController,
                    labelText: 'Confirm password',
                    suffixIcon: obscure.isObscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTap: () {
                      obscure.changeObscure();
                    },
                  ),
                  verticalSpace(addCustomer.status == false ? 5 : 0),
                  addCustomer.status == false
                      ? Text(
                          addCustomer.wrongPassword,
                          //wrongPassword,
                          style: AppTextStyles.font12.copyWith(
                            color: Colors.red,
                          ),
                        )
                      : Text(''),
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
                      if (firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      await addCustomer.registerCustomer(
                          email: emailController.text.trim(),
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          password: passwordController.text.trim(),
                          confirmPassword:
                              confirmPasswordController.text.trim());
                      if (addCustomer.status == false && context.mounted) {
                        showMessage(context, addCustomer.message);
                        log('${addCustomer.message}');
                        return;
                      }

                      if (addCustomer.status == true && context.mounted) {
                        showMessage(context, addCustomer.message);

                        nextScreen(context, DashBoardScreen());
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
