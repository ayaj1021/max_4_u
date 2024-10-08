import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class AboutMax4uScreen extends StatelessWidget {
  const AboutMax4uScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            verticalSpace(15),
            Text(
              'About Max4u',
              style: AppTextStyles.font18.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
            verticalSpace(25),
            Text(
              '''We empower agents and dealers with the tools to grow their business by earning commissions on sales. Our platform ensures secure transactions, compliance, and offers an easy-to-navigate interface for users and vendors alike, all while keeping costs low and service efficient.''',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xff475569),
              ),
            ),
            verticalSpace(15),
            Text(
              '''
We empower agents and dealers with the tools to grow their business by earning commissions on sales. Our platform ensures secure transactions, compliance, and offers an easy-to-navigate interface for users and vendors alike, all while keeping costs low and service efficient.
''',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xff475569),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
