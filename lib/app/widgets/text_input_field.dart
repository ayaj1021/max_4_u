import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TextInputField extends StatelessWidget {
  const TextInputField(
      {super.key,
      required this.controller,
      this.hintText,
      this.suffixIcon,
      this.onTap,
      this.labelText});
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? suffixIcon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText!,
          style: AppTextStyles.font14.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 52.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.borderColor)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.font14
                  .copyWith(color: AppColors.textColor.withOpacity(0.3)),
              border: InputBorder.none,
              suffixIcon:
                  GestureDetector(onTap: onTap, child: Icon(suffixIcon)),
            ),
          ),
        ),
      ],
    );
  }
}
