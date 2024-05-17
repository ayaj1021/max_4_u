import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class CustomerDetailsTabScreen extends StatelessWidget {
  const CustomerDetailsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomerDetailsSection(
          title: 'First Name',
          value: 'Praise',
        ),
        verticalSpace(16),
        const CustomerDetailsSection(
          title: 'Last Name',
          value: 'Adedokun',
        ),
        verticalSpace(16),
        const CustomerDetailsSection(
          title: 'Phone number',
          value: '0814568944',
        ),
        verticalSpace(16),
        const CustomerDetailsSection(
          title: 'Email',
          value: 'tobilobaphilipson@gmail.com',
        ),
      ],
    );
  }
}

class CustomerDetailsSection extends StatelessWidget {
  const CustomerDetailsSection({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.font14.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ),
        horizontalSpace(8),
        Text(
          value,
          style: AppTextStyles.font16.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.mainTextColor,
          ),
        ),
      ],
    );
  }
}
