import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class FaqQuestionSection extends StatelessWidget {
  const FaqQuestionSection({
    super.key, required this.question,
  });
final String question;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          question,
          style: AppTextStyles.font14.copyWith(
              color: const Color(0xff1A1A1A),
              fontWeight: FontWeight.w400),
        ),
        const Icon(Icons.remove)
      ],
    );
  }
}
