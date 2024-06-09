
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/provider/fund_account_provider.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen(
      {super.key, required this.paymentUrl, required this.token});
  final String paymentUrl;
  final String token;

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            const CircularProgressIndicator();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
           // Future.delayed(Duration(seconds: 10), () {
              Provider.of<FundAccountProvider>(context, listen: false)
                  .verifyPayment(paymentToken: widget.token, context: context).then((value) => nextScreen(context, DashBoardScreen()));
              log(widget.token);
          //  }).then((value) => nextScreen(context, DashBoardScreen()));
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
