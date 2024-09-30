import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/faq_question_section.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class VendorFaqSection extends StatelessWidget {
  const VendorFaqSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaqQuestionSection(
          question: 'How can i become a vendor?',
          iconData: Icons.add,
          index: 0,
          answer:
              'If you are an existing user, you can apply to upgrade your account to vendor status. You’ll need to submit personal details such as your BVN, NIN, a valid ID, and a selfie for verification.',
        ),
        verticalSpace(19),
        FaqQuestionSection(
          question:
              'Why do I need to provide my BVN and NIN to become a vendor?',
          iconData: Icons.add,
          index: 1,
          answer:
              'This is required for compliance purposes to ensure the authenticity of our vendors and to meet regulatory standards.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question: 'What happens after I submit my vendor application?',
          iconData: Icons.add,
          index: 2,
          answer:
              'After submission, the super admin will review your application. Once approved, you will receive a wallet number that allows for easy account top-up and vendor access at discounted rates.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question: 'What benefits do I get as a vendor?',
          iconData: Icons.add,
          index: 3,
          answer:
              'As a vendor, you can purchase airtime and data packages at a lower rate than regular users, allowing you to resell at a profit.',
        ),
        verticalSpace(19),
        const FaqQuestionSection(
          question: 'How do I top up my vendor wallet?',
          iconData: Icons.add,
          index: 4,
          answer:
              'Once your vendor status is approved, you will receive a wallet number. You can top up your wallet using the available payment methods in the app.',
        ),
      ],
    );
  }
}
