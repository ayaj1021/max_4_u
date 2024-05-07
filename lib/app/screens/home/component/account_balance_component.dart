import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class AccountBalanceWidget extends StatelessWidget {
  const AccountBalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
      height: 125.h,
      width: 358.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Wallet Balance',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    horizontalSpace(5),
                    const Icon(
                      Icons.visibility_off_outlined,
                      size: 12,
                      color: AppColors.whiteColor,
                    )
                  ],
                ),
                verticalSpace(12),
                Text(
                  '₦350,000,000',
                  style: AppTextStyles.font12.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: AppColors.whiteColor,
                  ),
                ),
              ]),
          Container(
            alignment: Alignment.center,
            height: 36.h,
            width: 104.w,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Fund wallet',
              style: AppTextStyles.font14.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
