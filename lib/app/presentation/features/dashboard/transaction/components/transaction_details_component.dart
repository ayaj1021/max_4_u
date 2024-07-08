import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class TransactionDetailsSection extends StatelessWidget {
  const TransactionDetailsSection({
    super.key,
    required this.title,
    required this.value,
    this.iconData,
  });

  final String title;
  final String value;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.font18.copyWith(color: const Color(0xff666666)),
        ),
      // horizontalSpace(120),
        Text(
          value,
          style: AppTextStyles.font16.copyWith(
            color: const Color(0xff666666),
          ),
        ),
      ],
    );
  }
}
