import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class CustomerDetailsTabScreen extends StatelessWidget {
  const CustomerDetailsTabScreen({super.key, required this.firstName, required this.lastName, required this.phoneNumber, required this.uniqueId});

  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String uniqueId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         CustomerDetailsSection(
          title: 'First Name',
          value: firstName,
        ),
        verticalSpace(16),
         CustomerDetailsSection(
          title: 'Last Name',
          value: lastName,
        ),
        verticalSpace(16),
         CustomerDetailsSection(
          title: 'Phone number',
          value: phoneNumber,
        ),
           verticalSpace(16),
          CustomerDetailsSection(
          title: 'User id:',
          value: uniqueId,
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
