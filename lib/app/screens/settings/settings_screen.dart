import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/screens/settings/bio_metric_auth_screen.dart';
import 'package:max_4_u/app/screens/settings/change_password_screen.dart';
import 'package:max_4_u/app/screens/settings/delete_account_screen.dart';
import 'package:max_4_u/app/screens/settings/email_notification_settings.dart';
import 'package:max_4_u/app/screens/settings/push_notification_settings.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/settings_option_section.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                horizontalSpace(119),
                const Text(
                  'Settings',
                  style: AppTextStyles.font18,
                )
              ],
            ),
            verticalSpace(25),
            Container(
              alignment: Alignment.center,
              height: 116.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SettingsOptionSection(
                    onTap: () =>
                        nextScreen(context, const ChangePasswordScreen()),
                    icon: 'assets/icons/profile_icon.png',
                    settingOption: 'Change password',
                  ),
                  verticalSpace(20),
                  SettingsOptionSection(
                    onTap: () =>
                        nextScreen(context, const BiometricAuthScreen()),
                    icon: 'assets/icons/setting_icon.png',
                    settingOption: 'Biometric Authentication',
                  ),
                ],
              ),
            ),
            verticalSpace(25),
            Container(
              alignment: Alignment.center,
              height: 116.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingsOptionSection(
                      onTap: () => nextScreen(
                          context, const PushNotificationSettingsScreen()),
                      icon: 'assets/icons/profile_icon.png',
                      settingOption: 'Push notification settings',
                    ),
                    verticalSpace(20),
                    SettingsOptionSection(
                      onTap: () => nextScreen(
                          context, const EmailNotificationSettingsScreen()),
                      icon: 'assets/icons/setting_icon.png',
                      settingOption: 'Email notification settings',
                    ),
                  ]),
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
              child: const SettingsOptionSection(
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
                onTap: () => nextScreen(context, const DeleteAccountScreen()),
                icon: 'assets/icons/setting_icon.png',
                settingOption: 'Delete account',
              ),
            ),
            verticalSpace(152),
            ButtonWidget(
              text: 'Log out',
              onTap: ()async {
                await SecureStorage().logoutUser();
                showMessage(context, 'Log out successful');
                nextScreenReplace(context, LoginScreen());  
              },
            )
          ],
        ),
      )),
    );
  }
}
