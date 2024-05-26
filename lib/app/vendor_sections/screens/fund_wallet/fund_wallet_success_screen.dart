import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class FundWalletSuccessScreen extends StatelessWidget {
  const FundWalletSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 67.h,
              width: 67.w,
              child: Image.asset('assets/icons/verify_icon.png'),
            ),
            verticalSpace(28),
            Text(
              'Transaction Successful ',
              style: AppTextStyles.font20.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(12),
            Text(
              'Transaction of N2,000 has been funded to your wallet. Check notification for transaction details.',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpace(50),
            ButtonWidget(
              text: 'Go to Dashboard',
              onTap: () async {
                nextScreen(context, DashBoardScreen());
              },
            )
          ],
        ),
      )),
    );
  }
}
