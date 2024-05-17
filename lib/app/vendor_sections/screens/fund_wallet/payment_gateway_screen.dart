import 'dart:async';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/vendor_sections/screens/fund_wallet/fund_wallet_success_screen.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({super.key});

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      nextScreen(context, const FundWalletSuccessScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Payment Gateway',
          style: AppTextStyles.font18.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
