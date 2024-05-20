

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class AutoRenewalTabs extends StatelessWidget {
  const AutoRenewalTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174.h,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xffE8E8E8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
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
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    '08139920396',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Network',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    'MTN',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    '500',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Data Bundle',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    '20GB',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(8),
          const ButtonWidget(
            text: 'Cancel auto renewal',
            textColor: AppColors.primaryColor,
            color: Color(0xffD9D9D9),
          )
        ],
      ),
    );
  }
}
