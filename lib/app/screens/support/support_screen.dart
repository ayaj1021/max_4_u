import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/faq_question_section.dart';
import 'package:max_4_u/app/widgets/settings_option_section.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 39, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Praise',
                style: AppTextStyles.font16.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'How can we help you today?',
                style: AppTextStyles.font12.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff333333),
                ),
              ),
              verticalSpace(24),
              Text(
                'Contact us',
                style: AppTextStyles.font18.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(9),
              Container(
                alignment: Alignment.center,
                height: 143.h,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    const SettingsOptionSection(
                        icon: 'assets/icons/whatsapp_icon.png',
                        settingOption: '09038177869'),
                    verticalSpace(20),
                    const SettingsOptionSection(
                        icon: 'assets/icons/sms_icon.png',
                        settingOption: 'Max4u@gmail.com'),
                    verticalSpace(20),
                    const SettingsOptionSection(
                        icon: 'assets/icons/call_icon.png',
                        settingOption: '07038177869'),
                  ],
                ),
              ),
              verticalSpace(24),
              Text(
                'Location',
                style: AppTextStyles.font18.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(9),
              Container(
                alignment: Alignment.center,
                height: 96.h,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/icons/location_icon.png'),
                        ),
                        horizontalSpace(12),
                        SizedBox(
                          width: 299.w,
                          child: Text(
                            'No.5 Ajayi avenue. Anifalaje bustop. Akobo. Ibadan, Oyo state',
                            style: AppTextStyles.font14.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(6),
                      Text(
                'Locate using google map',
                style: AppTextStyles.font12.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
                  ],
                ),
              ),
              verticalSpace(24),
              Text(
                'FAQs',
                style: AppTextStyles.font18.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              verticalSpace(9),
              Container(
                alignment: Alignment.center,
                height: 219.h,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    const FaqQuestionSection(
                        question: 'How can i become a vendor?'),
                    verticalSpace(19),
                    const FaqQuestionSection(
                        question: 'Do you offer other services?'),
                    verticalSpace(19),
                    const FaqQuestionSection(question: 'What are your rates'),
                    verticalSpace(19),
                    const FaqQuestionSection(
                        question: 'Do you sell data for all networks'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
