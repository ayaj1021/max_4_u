import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/faq_question_section.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class ConsumerFaqSection extends StatelessWidget {
  const ConsumerFaqSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaqQuestionSection(
          question: 'What is the purpose of this app?',
          iconData: Icons.add,
          index: 0,
          answer:
              'The app allows users to conveniently purchase airtime and data packages for various mobile networks directly from their smartphones.',
        ),
        verticalSpace(19),
        FaqQuestionSection(
          question: 'How do I register as a new user?',
          iconData: Icons.add,
          index: 1,
          answer:
              'To register, you need to provide a valid email address and phone number. Once registered, you can immediately start browsing and purchasing airtime or data packages.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question: 'What payment methods are available?',
          iconData: Icons.add,
          index: 2,
          answer:
              'You can make payments via debit/credit card, mobile wallets, or direct bank transfer, depending on the options provided in the app.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question: 'Can I purchase airtime and data for someone else?',
          iconData: Icons.add,
          index: 3,
          answer:
              'Yes, you can purchase airtime or data for any mobile number, not just your own.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question:
              'What should I do if I don’t receive my airtime or data after purchase?',
          iconData: Icons.add,
          index: 3,
          answer:
              '''If your purchase doesn't reflect, please check your transaction history. If the problem persists, contact customer support through the help section in the app.
''',
        ),
      ],
    );
  }
}
