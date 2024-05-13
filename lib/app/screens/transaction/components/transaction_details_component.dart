import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

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
          style: AppTextStyles.font14.copyWith(color: const Color(0xff666666)),
        ),
        horizontalSpace(100),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyles.font14.copyWith(
                color: const Color(0xff666666),
              ),
            ),
            Icon(
              iconData,
              color: const Color(0xff0072BF),
              size: 14,
            )
          ],
        ),
      ],
    );
  }
}
