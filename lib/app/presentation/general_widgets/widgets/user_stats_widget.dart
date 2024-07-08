import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class UsersStatsWidget extends StatelessWidget {
  const UsersStatsWidget(
      {super.key, required this.title, required this.number});
  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.font12.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.subTextColor,
          ),
        ),
        verticalSpace(12),
        Text(
          number,
          style: AppTextStyles.font16.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}
