import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class SuccessfulPriceSetScreen extends StatelessWidget {
  const SuccessfulPriceSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 67.h,
              width: 67.w,
              child: Image.asset('assets/images/verify_image.png'),
            ),
            verticalSpace(24),
            Text(
              'Price Set Successfully',
              style: AppTextStyles.font20.copyWith(
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            ButtonWidget(
                onTap: () => nextScreen(context, DashBoardScreen()),
                text: 'Continue')
          ],
        ),
      )),
    );
  }
}
