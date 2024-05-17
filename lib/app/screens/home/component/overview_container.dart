import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class OverViewContainer extends StatelessWidget {
  const OverViewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 19),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Total transactions',
                style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(12),
              Text(
                '8',
                style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333)),
              ),
            ],
          ),
          VerticalDivider(color: AppColors.blackColor.withOpacity(0.1)),
          Column(
            children: [
              Text(
                'Total customers',
                style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(12),
              Text(
                '90',
                style: AppTextStyles.font16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff333333)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
