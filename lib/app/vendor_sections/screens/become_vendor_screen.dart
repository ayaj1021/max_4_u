import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/vendor_sections/screens/bvn_input_screen.dart';
import 'package:max_4_u/app/vendor_sections/screens/face_authentication_screen.dart';
import 'package:max_4_u/app/vendor_sections/screens/upload_idCard_screen.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class BecomeVendorScreen extends StatelessWidget {
  const BecomeVendorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
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
                horizontalSpace(99),
                const Text(
                  'KYC Verification',
                  style: AppTextStyles.font18,
                )
              ],
            ),
            verticalSpace(32),
            Text(
              'Please upload and fill all necessary details to get verified',
              style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(
                    0xff333333,
                  )),
            ),
            verticalSpace(21),
            KycVerificationSection(
              icon: 'assets/icons/bvn_nin_icon.png',
              kycTask: 'BVN & NIN number',
              onTap: () => nextScreen(context, const BvnNinInputScreen()),
            ),
            verticalSpace(17),
            KycVerificationSection(
              icon: 'assets/icons/id_card_icon.png',
              kycTask: 'Your valid ID photo',
              onTap: () => nextScreen(context, const UploadIdCardScreen()),
            ),
            verticalSpace(17),
            KycVerificationSection(
              icon: 'assets/icons/take_selfie_icon.png',
              kycTask: 'Take a selfie',
              onTap: () =>
                  nextScreen(context, const FaceAuthenticationScreen()),
            ),
            verticalSpace(292),
            ButtonWidget(
              text: 'Verify',
              color: const Color(0xff919191),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 23),
                            height: 293.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 67.h,
                                  width: 67.w,
                                  child: Image.asset(
                                      'assets/icons/verify_icon.png'),
                                ),
                                verticalSpace(28),
                                Text(
                                  'Verification Sent',
                                  style: AppTextStyles.font16.copyWith(
                                    color: AppColors.mainTextColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                verticalSpace(13),
                                Text(
                                  'We will verify and notify you ',
                                  style: AppTextStyles.font14.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                verticalSpace(37),
                                SizedBox(
                                  width: 210.w,
                                  height: 48.h,
                                  child: ButtonWidget(
                                    text: 'Done',
                                    onTap: () => nextScreen(
                                        context, const DashBoardScreen()),
                                  ),
                                )
                              ],
                            ),
                          ));
                    });
              },
            )
          ],
        ),
      )),
    );
  }
}

class KycVerificationSection extends StatelessWidget {
  const KycVerificationSection({
    super.key,
    required this.icon,
    required this.kycTask,
    this.onTap,
  });

  final String icon;
  final String kycTask;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74.h,
      padding: const EdgeInsets.all(13),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.whiteColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(icon),
              ),
              horizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kycTask,
                    style: AppTextStyles.font14.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(4),
                  Text(
                    '(Not inputed)',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Color(0xff292D32),
            ),
          )
        ],
      ),
    );
  }
}
