import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class BiometricAuthScreen extends StatelessWidget {
  const BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                horizontalSpace(60),
                const Text(
                  'Biometric Authentication',
                  style: AppTextStyles.font18,
                )
              ],
            ),
           
            verticalSpace(25),
            Container(
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.fingerprint_outlined,
                        size: 24,
                      ),
                      horizontalSpace(10),
                      Text(
                        'Enable fingerprint for login',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff4F4F4F),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Transform.scale(
                    scale: 0.55,
                    child: Switch(
                      value: false,
                      onChanged: (value) {},
                      materialTapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Reduce the height of the switch
                    ),
                  )
                ],
              ),
            ),
            verticalSpace(16),
            Container(
              height: 56.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.fingerprint_outlined,
                        size: 24,
                      ),
                      horizontalSpace(10),
                      Text(
                        'Enable fingerprint for payment',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff4F4F4F),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Transform.scale(
                    scale: 0.55,
                    child: Switch(
                      value: false,
                      onChanged: (value) {},
                      materialTapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Reduce the height of the switch
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
