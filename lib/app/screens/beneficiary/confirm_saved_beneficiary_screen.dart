import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class ConfirmSavedBeneficiaryScreen extends StatelessWidget {
  const ConfirmSavedBeneficiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 67.h,
              width: 67.w,
              child: Image.asset('assets/icons/verify_icon.png'),
            ),
            verticalSpace(20),
            Text(
              'Beneficiary Saved Successfully',
              style: AppTextStyles.font16.copyWith(
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(56),
            ButtonWidget(
              text: 'Continue',
              onTap: () async{
            
                        nextScreen(context,  DashBoardScreen());

              }
            )
          ],
        ),
      )),
    );
  }
}
