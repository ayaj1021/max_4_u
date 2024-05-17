import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/vendor_sections/screens/fund_wallet/generate_account_number_screen.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class AccountNoPaymentScreen extends StatelessWidget {
  const AccountNoPaymentScreen({super.key});

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
                horizontalSpace(48),
                const Text(
                  'Bank Account(Fund Wallet)',
                  style: AppTextStyles.font18,
                ),
              ],
            ),
            verticalSpace(86),
            SizedBox(
              width: 330.w,
              child: RichText(
                text: TextSpan(
                    text: 'Click the ',
                    style: AppTextStyles.font14.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff979797),
                    ),
                    children: [
                      TextSpan(
                        text: 'Generate ',
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff979797),
                        ),
                      ),
                      TextSpan(
                        text:
                            'button below to receive your unique account number. You can use this account number to fund your wallet and start transactions."',
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff979797),
                        ),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
            verticalSpace(100),
            ButtonWidget(
              text: 'Generate',
              onTap: () =>
                  nextScreen(context, const GenerateAccountNumberScreen()),
            )
          ],
        ),
      )),
    );
  }
}
