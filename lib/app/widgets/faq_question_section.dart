import 'package:flutter/material.dart';
import 'package:max_4_u/app/provider/faq_provider.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class FaqQuestionSection extends StatelessWidget {
  const FaqQuestionSection(
      {super.key,
      required this.question,
      required this.iconData,
      required this.index,
      this.answer});
  final String question;

  final IconData iconData;
  final int index;
  final String? answer;

  @override
  Widget build(BuildContext context) {
    return Consumer<FaqProvider>(builder: (context, faqProvider, child) {
      bool isTapped = faqProvider.activeFaqIndex == index;
      return InkWell(
        onTap: () {
          faqProvider.setActiveFaqIndex(index);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  question,
                  style: AppTextStyles.font18.copyWith(
                      color: const Color(0xff1A1A1A),
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    faqProvider.setActiveFaqIndex(index);
                  },
                  child: Icon(isTapped ? Icons.remove : Icons.add),
                )
              ],
            ),
            isTapped && answer != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(answer!),
                  )
                : SizedBox.shrink(),
            // verticalSpace(isTapped ? 5 : 19),
          ],
        ),
      );
    });
  }
}
