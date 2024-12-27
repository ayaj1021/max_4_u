import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/fund_wallet/fund_account_validation_screen.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
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
  bool isLoading = true;
  double loadingProgress = 0.0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            nextScreen(
                context,
                FundAccountValidationScreen(
                  token: widget.token,
                ));
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: loadingProgress,
                  ),
                  SizedBox(height: 10),
                  Text('Loading... ${loadingProgress.toStringAsFixed(0)}%')
                ],
              ),
            )
        ],
      ),
    );
  }
}
