import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class GenerateAccountNumberScreen extends StatelessWidget {
  const GenerateAccountNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                horizontalSpace(48),
                const Text(
                  'Bank Account(Fund Wallet)',
                  style: AppTextStyles.font18,
                ),
              ],
            ),
            verticalSpace(80),
            Container(
              height: 200.h,
              width: 331.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 29, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffDEDEDE),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BANK NAME',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    'Wema Bank',
                    style: AppTextStyles.font18.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  verticalSpace(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'ACCOUNT NUMBER',
                            style: AppTextStyles.font12.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.textColor,
                            ),
                          ),
                          Text(
                            '0303837382',
                            style: AppTextStyles.font18.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.copy,
                        color: AppColors.primaryColor,
                        size: 18,
                      )
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(56),
            Text(
              'How to pay using bank account',
              style: AppTextStyles.font16.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textColor,
              ),
            ),
            verticalSpace(8),
            Text(
              'i.Copy account number from above',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
            verticalSpace(8),
            Text(
              'ii.Transfer desired amount from your bank to the copied account number',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
            verticalSpace(8),
            Text(
              'iii.Check your dashboard',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
