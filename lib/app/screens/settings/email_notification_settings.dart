import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class EmailNotificationSettingsScreen extends StatelessWidget {
  const EmailNotificationSettingsScreen({super.key});

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
                horizontalSpace(60),
                 Text(
                  'Email Notification Settings',
                  style: AppTextStyles.font18,
                )
              ],
            ),
            verticalSpace(25),
            const PushNotificationOption(
                title: 'Transactions',
                value: 'Get notified on your transaction activities'),
            verticalSpace(20),
            const PushNotificationOption(
                title: 'News',
                value: 'Get notified on your transaction activities'),
            verticalSpace(20),
            const PushNotificationOption(
                title: 'Offers and discounts',
                value: 'Get notified on your transaction activities'),
          ],
        ),
      )),
    );
  }
}

class PushNotificationOption extends StatelessWidget {
  const PushNotificationOption({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 76.h,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font14.copyWith(
                    color: const Color(0xff4F4F4F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                verticalSpace(4),
                Text(
                  value,
                  style: AppTextStyles.font12.copyWith(
                    color: const Color(0xff4F4F4F),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 0.55,
              child: Switch(
                value: false,
                onChanged: (value) {},
                materialTapTargetSize: MaterialTapTargetSize
                    .shrinkWrap, // Reduce the height of the switch
              ),
            )
          ],
        ));
  }
}
