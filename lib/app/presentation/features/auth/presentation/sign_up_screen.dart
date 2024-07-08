import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/login_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/verification_screen.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Country country = CountryParser.parseCountryCode('NG');

  void showPicker() {
    showCountryPicker(
        context: context,
        countryListTheme: CountryListThemeData(
            bottomSheetHeight: 600,
            // backgroundColor: AppColors.primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            inputDecoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Select your country here',
              border: InputBorder.none,
            )),
        onSelect: (country) {
          setState(() {
            this.country = country;
          });
        });
  }

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
                  Text(
                    'Welcome to Max4u!',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(12),
                  Text(
                    'Input your whatsapp enabled phone number to get started',
                    style: AppTextStyles.font14
                        .copyWith(color: const Color(0xff475569)),
                  ),
                  verticalSpace(24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 52.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.borderColor)),
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 11,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        counterText: '',

                        hintStyle: AppTextStyles.font14.copyWith(
                            color: AppColors.textColor.withOpacity(0.3)),
                        border: InputBorder.none,
                        // prefixIcon: GestureDetector(
                        //   behavior: HitTestBehavior.opaque,
                        //   onTap: showPicker,
                        //   child: Container(
                        //     height: 40.w,
                        //     width: 60.w,
                        //     alignment: Alignment.center,
                        //     child: Text(
                        //       '${country.flagEmoji} + ${country.phoneCode} ',
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  // TextInputField(
                  //   controller: _phoneController,
                  //   labelText: 'Phone number',
                  //   textInputType: TextInputType.number,
                  //   prefixIcon: Container(
                  //     height: 40.w,
                  //     width: 100.w,
                  //     alignment: Alignment.center,
                  //     child: Text('+91'),
                  //   ),
                  // ),

                  verticalSpace(32),
                  ButtonWidget(
                    onTap: () async {
                      if (_phoneController.text.isEmpty) {
                        showMessage(context, 'Phone number is required',
                            isError: true);
                        return;
                      }

                      if (_phoneController.text.length > 11) {
                        showMessage(context, 'Invalid phone number',
                            isError: true);
                        return;
                      }

                      await authProv.signUp(
                          phoneNumber: _phoneController.text.trim());
                      if (authProv.status == false && context.mounted) {
                        showMessage(context, authProv.message);
                        return;
                      }

                      if (authProv.status == true && context.mounted) {
                        showMessage(context, authProv.message);

                        nextScreen(
                            context,
                            VerificationScreen(
                              phoneNumber: _phoneController.text,
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
