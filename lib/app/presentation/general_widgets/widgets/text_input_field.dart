import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixIcon,
    this.onTap,
    this.labelText,
    this.prefixIcon,
    this.prefixOnTap,
    this.enable,
    this.obscure = false,
    this.textInputType,
    this.onChanged,
    this.maxLength,
  });
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool obscure;
  final bool? enable;
  final Function()? onTap;
  final Function()? prefixOnTap;
  final Function(String?)? onChanged;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? '',
          style: AppTextStyles.font14.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
       //   height: 52.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              //  color: AppColors.whiteColor,
              border: Border.all(color: AppColors.borderColor)),
          child: TextField(
            enabled: enable ?? true,
            controller: controller,
            keyboardType: textInputType,
            obscureText: obscure,
            maxLength: maxLength,
            onChanged: onChanged,
            style: AppTextStyles.font14,
            decoration: InputDecoration(
              counterText: '',
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
