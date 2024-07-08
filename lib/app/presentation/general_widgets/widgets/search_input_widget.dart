import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget(
      {super.key,
      required this.controller,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged});

  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? suffixIcon;
  final Widget? prefixIcon;

  final Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 52.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffE6E6E6),
        
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.font14
              .copyWith(color: AppColors.textColor.withOpacity(0.3)),
          border: InputBorder.none,
          prefixIcon: GestureDetector(
            child: prefixIcon ?? const SizedBox(),
            //  Icon(
            //   prefixIcon,
            //   color: const Color(0xff4F4F4F),
            // )
          ),
        ),
      ),
    );
  }
}
