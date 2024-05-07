import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.text, this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 48.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primaryColor,
        ),
        child: Text(
          text,
          style: AppTextStyles.font16.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
