import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/buy_data/data_confirmation_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class DataVerificationScreen extends StatelessWidget {
  const DataVerificationScreen({super.key});

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
                horizontalSpace(104),
                const Text(
                  'Confirmation',
                  style: AppTextStyles.font18,
                ),
              ],
            ),
            verticalSpace(52),
            Text(
              'Select airtime to',
              style: AppTextStyles.font14.copyWith(
                color: const Color(0xff475569),
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(4),
            Container(
              padding: const EdgeInsets.all(13),
              height: 125.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone number',
                            style: AppTextStyles.font12.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text('08139920396',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Network',
                            style: AppTextStyles.font12.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text('MTN',
                              style: AppTextStyles.font16.copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      )
                    ],
                  ),
                  verticalSpace(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: AppTextStyles.font12.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text('500',
                          style: AppTextStyles.font16.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(349),
            ButtonWidget(
              text: 'Send data',
              onTap: () => nextScreen(
                context,
                const DataConfirmationScreen(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
