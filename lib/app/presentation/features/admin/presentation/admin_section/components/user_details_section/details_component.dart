import 'package:flutter/material.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class DetailsComponent extends StatelessWidget {
  const DetailsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllAppUsers>(builder: (context, getAllAppUsers, _) {
      //  final data = getAllAppUsers
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomerDetailsWidget(
            title: 'First Name',
            value: '${getAllAppUsers.firstName}',
          ),
          verticalSpace(16),
          CustomerDetailsWidget(
            title: 'Last Name',
            value: '${getAllAppUsers.lastName}',
          ),
           verticalSpace(16),
          CustomerDetailsWidget(
            title: 'Phone Number',
            value: '${getAllAppUsers.phoneNumber}',
          ),
            verticalSpace(16),
          CustomerDetailsWidget(
            title: 'Email',
            value: '${getAllAppUsers.email}',
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
