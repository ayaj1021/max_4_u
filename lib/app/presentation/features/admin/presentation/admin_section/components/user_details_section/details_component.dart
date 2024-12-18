import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class DetailsComponent extends StatelessWidget {
  const DetailsComponent(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.email});
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllAppUsers>(builder: (context, getAllAppUsers, _) {
      return Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomerDetailsWidget(
                title: 'First Name',
                value: '${firstName}',
              ),
              verticalSpace(16),
              CustomerDetailsWidget(
                title: 'Last Name',
                value: '${lastName}',
              ),
              verticalSpace(16),
              CustomerDetailsWidget(
                title: 'Phone Number',
                value: '${phoneNumber}',
              ),
              verticalSpace(16),
              CustomerDetailsWidget(
                title: 'Email',
                value: '${email}',
              ),
            ],
          ),
        ],
      );
    });
  }
}

class CustomerDetailsWidget extends StatelessWidget {
  const CustomerDetailsWidget({
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
            color: AppColors.textColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        horizontalSpace(8),
        Text(
          value,
          style: AppTextStyles.font16.copyWith(color: AppColors.mainTextColor),
        )
      ],
    );
  }
}
