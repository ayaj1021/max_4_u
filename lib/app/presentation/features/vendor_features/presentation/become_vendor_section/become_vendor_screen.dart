import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/kyc_verification/bvn_input_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/kyc_verification/face_authentication_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/kyc_verification/upload_idcard_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class BecomeVendorScreen extends StatefulWidget {
  const BecomeVendorScreen({super.key});

  @override
  State<BecomeVendorScreen> createState() => _BecomeVendorScreenState();
}

class _BecomeVendorScreenState extends State<BecomeVendorScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ReloadUserDataProvider, BecomeAVendorProvider>(
      builder: (context, reloadData, becomeVendor, _) {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
              child: reloadData.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : Column(
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
                             Text(
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
                          kycTask: 'BVN & NIN number ',
                          status:
                              'BVN: ${reloadData.loadData.verificationStatus!.bvn}, NIN: ${reloadData.loadData.verificationStatus!.nin}',
                          onTap: () =>
                              nextScreen(context, const BvnNinInputScreen()),
                        ),
                        verticalSpace(17),
                        KycVerificationSection(
                          icon: 'assets/icons/id_card_icon.png',
                          kycTask: 'Your valid ID photo',
                          status:
                              '${reloadData.loadData.verificationStatus!.ninImageLink}',
                          onTap: () =>
                              nextScreen(context, const UploadIdCardScreen()),
                        ),
                        verticalSpace(17),
                        KycVerificationSection(
                          icon: 'assets/icons/take_selfie_icon.png',
                          kycTask: 'Take a selfie',
                          status:
                              '${reloadData.loadData.verificationStatus!.vendorImageLink}',
                          onTap: () => nextScreen(
                              context, const FaceAuthenticationScreen()),
                        ),
                        verticalSpace(200),
                        ButtonWidget(
                          text: 'Verify',
                          color: reloadData.loadData.verificationStatus!.bvn ==
                                  'not_done'
                              ? const Color(0xff919191)
                              : reloadData.loadData.verificationStatus!.nin ==
                                      'not_done'
                                  ? const Color(0xff919191)
                                  : reloadData.loadData.verificationStatus!
                                              .ninImageLink ==
                                          'not_done'
                                      ? const Color(0xff919191)
                                      : reloadData.loadData.verificationStatus!
                                                  .vendorImageLink ==
                                              'not_done'
                                          ? const Color(0xff919191)
                                          : AppColors.primaryColor,
                          onTap: () async {
                            if (reloadData.loadData.verificationStatus!.bvn == 'not_done' ||
                                reloadData.loadData.verificationStatus!.nin ==
                                    'not_done' ||
                                reloadData.loadData.verificationStatus!
                                        .ninImageLink ==
                                    'not_done' ||
                                reloadData.loadData.verificationStatus!
                                        .vendorImageLink ==
                                    'not_done') {
                              showMessage(
                                  context, 'Please fill all requirements');
                            } else {
                              await becomeVendor.sendBecomeVendorRequest();

                              if (becomeVendor.status == false &&
                                  context.mounted) {
                                showMessage(context, becomeVendor.message,
                                    isError: true);
                                return;
                              }

                              if (becomeVendor.status == true &&
                                  context.mounted) {
                                showMessage(
                                  context,
                                  becomeVendor.message,
                                  // isError: true,
                                );

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 23),
                                            height: 293.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 67.h,
                                                  width: 67.w,
                                                  child: Image.asset(
                                                      'assets/icons/verify_icon.png'),
                                                ),
                                                verticalSpace(28),
                                                Text(
                                                  '${becomeVendor.message}',
                                                  style: AppTextStyles.font16
                                                      .copyWith(
                                                    color:
                                                        AppColors.mainTextColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                verticalSpace(37),
                                                SizedBox(
                                                  width: 210.w,
                                                  height: 48.h,
                                                  child: ButtonWidget(
                                                    text: 'Done',
                                                    onTap: () async {
                                                   //   Navigator.pop(context);
                                                      await reloadData
                                                          .reloadUserData();
                                                      nextScreen(context,
                                                          DashBoardScreen());
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              }
                            }
                          },
                        )
                      ],
                    ),
            ),
          )),
        );
      },
    );
  }
}

class KycVerificationSection extends StatelessWidget {
  const KycVerificationSection({
    super.key,
    required this.icon,
    required this.kycTask,
    this.onTap,
    required this.status,
  });

  final String icon;
  final String kycTask;
  final String status;
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
      child: GestureDetector(
        onTap: onTap,
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
                      status,
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
      ),
    );
  }
}
