import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class ValidityDateWidget extends StatelessWidget {
  const ValidityDateWidget({
    super.key,
    required this.date,
    this.onTap,
    required this.dateLabel,
  });

  final String date;
  final String dateLabel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        dateLabel,
        style: AppTextStyles.font14.copyWith(
          color: const Color(0xff475569),
          fontWeight: FontWeight.w500,
        ),
      ),
      verticalSpace(8),
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52.h,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Color(0xffBDBDBD),
            ),
          ),
          child: Text(
            date,
            style: AppTextStyles.font14.copyWith(
              color: const Color(0xffAAA3A3),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      )
    ]);
  }
}
