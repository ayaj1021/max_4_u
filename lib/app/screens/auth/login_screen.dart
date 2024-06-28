import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
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
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  late final LocalAuthentication auth;
  // ignore: unused_field
  bool _supportState = false;

  @override
  void initState() {
    auth = LocalAuthentication();
    super.initState();
    auth.isDeviceSupported().then((bool isSupported) {
      setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProviderImpl, ObscureTextProvider,
            ReloadUserDataProvider>(
        builder: (context, authProv, obscure, reloadData, _) {
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
                  Text(
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
                    controller: _emailController,
                    labelText: 'Email/Phone number',
                    hintText: 'Enter your email or phone number',
                  ),
                  verticalSpace(24),
                  TextInputField(
                    obscure: obscure.isObscure,
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
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
                      if (_passwordController.text.isEmpty ||
                          _emailController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      await authProv.loginUser(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());

                      if (authProv.status == false && context.mounted) {
                        showMessage(context, authProv.errorMessage, isError: true);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text(authProv.errorMessage)));
                        return;
                      }

                      //print(authProv.message);

                      // final userLevelType = await SecureStorage().getUserType();
                      if (authProv.status == true && context.mounted) {
                        showMessage(context, authProv.message);
                        await reloadData.reloadUserData();
                        Future.delayed(Duration(seconds: 2), () {
                          nextScreenReplace(context, DashBoardScreen());
                        });
                        // nextScreen(context, DashBoardScreen());
                      }
                      final firstName = EncryptData.decryptAES(
                          '${authProv.resDataData.userData![0].firstName}');
                      // '${result.data!.userData![0].firstName}');
                      await SecureStorage().saveFirstName(firstName);

                      final lastName = EncryptData.decryptAES(
                          '${authProv.resDataData.userData![0].lastName}');
                      log('last name is $lastName');
                      final uniqueId = EncryptData.decryptAES(
                          '${authProv.resDataData.userData![0].uniqueId}');
                      log('uniqueId is $uniqueId');
                      final email = EncryptData.decryptAES(
                          '${authProv.resDataData.userData![0].email}');
                      log('uniqueId is $email');
                      final number = EncryptData.decryptAES(
                          '${authProv.resDataData.userData![0].mobileNumber}');
                      log('number is $number');
                      final balance = authProv.resDataData.userAccount!.balance;
                      final userType = authProv.resDataData.userData![0].level;
                      // context.read();
                      final transactionHistory =
                          authProv.resDataData.transactionHistory!.data;
                      final beneficiary = authProv.resDataData.beneficiaryData;
                      log('user type is $uniqueId');
                      log('user very unique id is $uniqueId');
                      log('user balance is $balance');
                      final services = authProv.resDataData.services!;
                      final products = authProv.resDataData.products!;
                      final autoRenewal =
                          authProv.resDataData.autoRenewal!.data;
                      //                  final transactions = result.data.;
                      // await SecureStorage().saveUserTransactions(transactions);

                      await SecureStorage().saveUserEncryptedId(
                          '${authProv.resDataData.userData![0].uniqueId}');
                      //  await SecureStorage().saveUserEncryptedId(uniqueId);
                      await SecureStorage()
                          .saveUserTransactionHistory(transactionHistory!);
                      await SecureStorage().saveUserBeneficiary(beneficiary!);
                      await SecureStorage().saveUserAutoRenewal(autoRenewal!);
                      await SecureStorage().saveUserProducts(products);
                      await SecureStorage().saveUserServices(services as List);
                      await SecureStorage().saveUserType(userType.toString());
                      await SecureStorage().saveEncryptedID(uniqueId);
                      await SecureStorage().saveUserBalance(balance.toString());
                      await SecureStorage().saveFirstName(firstName);
                      await SecureStorage().saveLastName(lastName);
                      await SecureStorage().saveUniqueId(uniqueId);
                      await SecureStorage().saveEmail(email);
                      await SecureStorage().savePhoneNumber(number);
                    },
                    text: 'Log in',
                  ),
                  // verticalSpace(20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     GestureDetector(
                  //       onTap: () async => await _authenticate(),
                  //       child: const Icon(
                  //         Icons.fingerprint_outlined,
                  //         color: AppColors.primaryColor,
                  //       ),
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

  Future<void> _authenticate() async {
    final email = await SecureStorage().getUserEmail();
    final password = await SecureStorage().getUserPassword();

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    final availableBiometrics = await auth.getAvailableBiometrics();

    if (canAuthenticate && availableBiometrics.isNotEmpty) {
      bool didAuthenticate = false;
      try {
        didAuthenticate = await auth.authenticate(
            localizedReason:
                'Please authenticate with Fingerprint or Face ID to proceed with login',
            options: const AuthenticationOptions(
                biometricOnly: true, stickyAuth: true));
      } on PlatformException {
        // print(e);
        // if (e.code == auth_error.notAvailable ||
        //     e.code == auth_error.notEnrolled) {}
      }
      if (didAuthenticate) {
        _emailController.text = email;
        _passwordController.text = password;
        if (!mounted) return;

        final authProv = Provider.of<AuthProviderImpl>(context);

        await authProv.loginUser(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        return;
      }
      if (!mounted) return;
      showMessage(
        context,
        'Invalid credentials',
      );
      return;
    }
    if (!mounted) return;
    showMessage(
      context,
      'Biometric Authorization not Available',
    );
    return;
  }
}


    // Future<void> _getAvailableBiometric() async {
    //   List<BiometricType> availableBiometrics =
    //       await auth.getAvailableBiometrics();
    //   print('List of available biometrics: $availableBiometrics');

    //   if (!mounted) {
    //     return;
    //   }
    // }
  

