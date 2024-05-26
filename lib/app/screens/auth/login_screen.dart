import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/user_account_model.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/screens/auth/forgot_password_screen1.dart';
import 'package:max_4_u/app/screens/auth/sign_up_screen.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
                    controller: emailController,
                    labelText: 'Email',
                    hintText: 'Input your email',
                  ),
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
                  verticalSpace(16),
                  GestureDetector(
                    onTap: () =>
                        nextScreen(context, const ForgotPasswordScreen1()),
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.font14
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                  ),
                  verticalSpace(32),
                  ButtonWidget(
                    onTap: () async {
                      // print('this is encrypt value $value');
                      //  print('this is decrypt value  $newValue');
                      if (passwordController.text.isEmpty ||
                          emailController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      final result = await authProv.loginUser(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim());
                      print(
                          'Animalllll: ${result.data!.userData![0].firstName}');
                      if (authProv.status == false && context.mounted) {
                        showMessage(context, authProv.message);
                        return;
                      }

                      print(authProv.message);

                      // final userLevelType = await SecureStorage().getUserType();
                      if (authProv.status == true && context.mounted) {
                        showMessage(context, authProv.message);

                        nextScreen(context, DashBoardScreen());
                      }
                      // final firstName = EncryptData.decryptAES(
                      //     '${data.userData}');

                      // final lastName = EncryptData.decryptAES(
                      //     '${data.lastName}');
                      // log('last name is $lastName');
                      // final uniqueId = EncryptData.decryptAES(
                      //     '${data.uniqueId}');
                      // log('uniqueId is $uniqueId');
                      // final email = EncryptData.decryptAES(
                      //     '${data.email}');
                      // log('uniqueId is $email');
                      // final number = EncryptData.decryptAES(
                      //     '${data.mobileNumber}');
                      // log('number is $number');
                      // final balance = data.balance;
                      // final userType = data.level;
                      // log('user type is $userType');
                      // log('user balance is $balance');
                      // await SecureStorage().saveUserType(userType.toString());
                      // await SecureStorage()
                      //     .saveEncryptedID(uniqueId);
                      // await SecureStorage().saveUserBalance(balance.toString());
                      // await SecureStorage().saveFirstName(firstName);
                      // await SecureStorage().saveLastName(lastName);
                      // await SecureStorage().saveUniqueId(uniqueId);
                      // await SecureStorage().saveEmail(email);
                      // await SecureStorage().savePhoneNumber(number);
                    },
                    text: 'Log in',
                  ),
                  // verticalSpace(20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     const Icon(
                  //       Icons.fingerprint_outlined,
                  //       color: AppColors.primaryColor,
                  //     ),
                  //     horizontalSpace(8),
                  //     Text(
                  //       'Click to login with fingerprint',
                  //       style: AppTextStyles.font14.copyWith(
                  //         color: AppColors.primaryColor,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  verticalSpace(260),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Are you new to Max4u? ',
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
        ),
      );
    });
  }
}
