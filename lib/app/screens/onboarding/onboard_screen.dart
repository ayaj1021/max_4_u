import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_pages/onboard_page_one.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_pages/onboard_page_two.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(child: Column(

        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [
                OnboardPageOne(),
                OnboardPageTwo(),
              ],
            ),
          )
        ]
      ))
    );
  }
}