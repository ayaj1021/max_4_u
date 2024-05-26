import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class OnboardPageTwo extends StatelessWidget {
  const OnboardPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 447.h,
                  width: width,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  child: Image.asset(
                    'assets/images/onboard_image2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 440.h,
                  //height / 2,
                  width: width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xffD9D9D9),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'The platform for airtime & data vendors',
                        style: AppTextStyles.font20.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        'Be a vendor and get access to airtime and data purchase at a cheaper rate to sell to your customers',
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
