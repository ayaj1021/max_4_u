import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_pages/onboard_page_one.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_pages/onboard_page_two.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  static const routeName = '/onboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                OnboardPageOne(
                  pageController: _pageController,
                ),
                OnboardPageTwo(
                  pageController: _pageController,
                ),
              ],
            ),
          )
        ]),
        Positioned(
          bottom: 40,
          left: 20,
          child: SizedBox(
            width: 358.w,
            child: Column(
              children: [
                verticalSpace(50),
               
              ],
            ),
          ),
        )
      ],
    ));
  }
}
