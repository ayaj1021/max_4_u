import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/login_screen.dart';
import 'package:max_4_u/app/presentation/features/settings/about_max4u_screen.dart';
import 'package:max_4_u/app/presentation/features/settings/change_password_screen.dart';
import 'package:max_4_u/app/presentation/features/settings/delete_account_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/settings_option_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            AppColors.primaryColor, // Set your desired status bar color here
        statusBarIconBrightness: Brightness.dark, // Set light or dark icons
      ),
    );
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                horizontalSpace(129),
                Text(
                  'Settings',
                  style: AppTextStyles.font18,
                )
              ],
            ),
            verticalSpace(25),
            Container(
              alignment: Alignment.center,
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SettingsOptionSection(
                    iconData: Icons.arrow_forward_ios,
                    onTap: () =>
                        nextScreen(context, const ChangePasswordScreen()),
                    icon: 'assets/icons/profile_icon.png',
                    settingOption: 'Change password',
                  ),
                  // verticalSpace(20),
                  // SettingsOptionSection(
                  //   onTap: () =>
                  //       nextScreen(context, const BiometricAuthScreen()),
                  //   icon: 'assets/icons/setting_icon.png',
                  //   settingOption: 'Biometric Authentication',
                  // ),
                ],
              ),
            ),
            // verticalSpace(25),
            // Container(
            //   alignment: Alignment.center,
            //   height: 116.h,
            //   width: MediaQuery.of(context).size.width,
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     color: AppColors.whiteColor,
            //   ),
            //   child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SettingsOptionSection(
            //           onTap: () => nextScreen(
            //               context, const PushNotificationSettingsScreen()),
            //           icon: 'assets/icons/profile_icon.png',
            //           settingOption: 'Push notification settings',
            //         ),
            //         verticalSpace(20),
            //         SettingsOptionSection(
            //           onTap: () => nextScreen(
            //               context, const EmailNotificationSettingsScreen()),
            //           icon: 'assets/icons/setting_icon.png',
            //           settingOption: 'Email notification settings',
            //         ),
            //       ]),
            // ),

            verticalSpace(25),
            Container(
              alignment: Alignment.center,
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: SettingsOptionSection(
                onTap: () => nextScreen(context, const AboutMax4uScreen()),
                iconData: Icons.arrow_forward_ios,
                icon: 'assets/icons/profile_icon.png',
                settingOption: 'About Max4u',
              ),
            ),
            verticalSpace(25),
            Container(
              alignment: Alignment.center,
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: SettingsOptionSection(
                iconData: Icons.arrow_forward_ios,
                onTap: () => nextScreen(context, const DeleteAccountScreen()),
                icon: 'assets/icons/setting_icon.png',
                settingOption: 'Delete account',
              ),
            ),
            verticalSpace(152),
            ButtonWidget(
              text: 'Log out',
              onTap: () {
                logoutAlertDialog(context);

                // nextScreenReplace(context, LoginScreen());
              },
            )
          ],
        ),
      )),
    );
  }

  Future<dynamic> logoutAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: 170.h,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want log out?',
                      style: AppTextStyles.font16.copyWith(
                        color: const Color(0xff4F4F4F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 117.w,
                            height: 44.h,
                            child: ButtonWidget(
                              color: Color(0xff219653),
                              textColor: AppColors.whiteColor,
                              text: 'Yes, Proceed',
                              onTap: () async {
                                await SecureStorage().logoutUser();
                                showMessage(context, 'Log out successful');
                                nextScreenReplace(context, LoginScreen());
                              },
                            )),
                        SizedBox(
                            width: 117.w,
                            height: 44.h,
                            child: ButtonWidget(
                                onTap: () => Navigator.pop(context),
                                color: Color(0xffF2C94C),
                                text: 'No, Cancel')),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
