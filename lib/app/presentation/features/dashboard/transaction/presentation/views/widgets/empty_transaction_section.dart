import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class EmptyTransactionSection extends StatelessWidget {
  const EmptyTransactionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 92.h,
                width: 92.w,
                child: Image.asset(
                    'assets/images/no_beneficiary_image.png')),
            verticalSpace(24),
            Text(
              'You have no transaction yet',
              style: AppTextStyles.font14.copyWith(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      );
  }
}
