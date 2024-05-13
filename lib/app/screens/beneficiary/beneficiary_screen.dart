import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class BeneficiaryScreen extends StatelessWidget {
  const BeneficiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                horizontalSpace(104),
                const Text(
                  'Beneficiary List',
                  style: AppTextStyles.font18,
                ),
              ],
            ),
            verticalSpace(48),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peace Adedokun',
                          style: AppTextStyles.font14.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400),
                        ),
                        verticalSpace(4),
                        const Text(
                          '93395853348',
                          style: AppTextStyles.font18,
                        ),
                        verticalSpace(16)
                      ],
                    );
                  }),
            )
          ],
        ),
      )),
    );
  }
}
