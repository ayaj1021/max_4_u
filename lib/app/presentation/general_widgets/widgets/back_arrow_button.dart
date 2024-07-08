import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({
    super.key, this.onTap,
  });
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 20.h,
        width: 20.w,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.borderColor),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          size: 12,
        ),
      ),
    );
  }
}
