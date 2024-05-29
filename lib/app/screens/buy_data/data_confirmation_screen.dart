import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/beneficiary/save_beneficiary_screen.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class DataConfirmationScreen extends StatelessWidget {
  const DataConfirmationScreen({super.key, required this.amount, required this.phoneNumber});
  final String amount;
  final String phoneNumber;

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
              'Data Purchased Successfully',
              style: AppTextStyles.font16.copyWith(
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(12),
            Text(
              'Data of $amount has been successfully \nsent to',
              style: AppTextStyles.font14.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              phoneNumber,
              style: AppTextStyles.font14.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            verticalSpace(84),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 48.h,
                  width: 155.w,
                  child: ButtonWidget(
                    text: 'Continue',
                    onTap: ()async {

                      
                        nextScreen(context,  DashBoardScreen());
                    }
                      
                  ),
                ),
                SizedBox(
                  height: 48.h,
                  width: 155.w,
                  child: ButtonWidget(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      color: AppColors.primaryColor,
                    ),
                    text: 'Save beneficiary',
                    textColor: AppColors.primaryColor,
                    onTap: () =>
                        nextScreen(context, const SaveBeneficiaryScreen(phoneNumber: '',)),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
