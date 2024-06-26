import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/screens/auth/sign_up_screen.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_pages/onboard_page_one.dart';
import 'package:max_4_u/app/screens/onboarding/onboard_pages/onboard_page_two.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

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
              children: const [
                OnboardPageOne(),
                OnboardPageTwo(),
              ],
            ),
          )
        ]),
        Positioned(
          bottom: 50,
          left: 20,
          child: SizedBox(
            width: 358.w,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 14.h,
                  width: 43.w,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: JumpingDotEffect(
                      activeDotColor: AppColors.secondaryColor,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                ),
                verticalSpace(50),
                ButtonWidget(
                  text: 'Create an account',
                  onTap: () => nextScreen(context, const SignUpScreen()),
                ),
                verticalSpace(10),
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        nextScreenReplace(context, const LoginScreen()),
                    child: Text(
                      'Log in',
                      style: AppTextStyles.font16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
