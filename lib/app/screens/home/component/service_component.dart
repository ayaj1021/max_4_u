import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class ServiceComponent extends StatelessWidget {
  const ServiceComponent({
    super.key,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceColor,
    this.margin ,
  });
  final String serviceName;
  final IconData serviceIcon;
  final Color serviceColor;
  final double? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      margin: EdgeInsets.only(right: margin ?? 0),
      alignment: Alignment.center,
      height: 70.h,
      width: 169.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: serviceColor,
            ),
            child: Icon(serviceIcon),
          ),
          horizontalSpace(12),
          Text(
            serviceName.substring(0).toUpperCase(),
            style: AppTextStyles.font14.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

