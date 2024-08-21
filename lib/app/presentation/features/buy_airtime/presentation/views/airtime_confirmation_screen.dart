import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/presentation/save_beneficiary_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/airtime_autorenewal_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AirtimeConfirmationScreen extends StatelessWidget {
  const AirtimeConfirmationScreen(
      {super.key,
      required this.amount,
      required this.number,
      required this.productCodes});

  final String amount;
  final String number;

  final String productCodes;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(builder: (context, reloadData, _) {
      return BusyOverlay(
        show: reloadData.state == ViewState.Busy,
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 67.h,
                  width: 67.w,
                  child: Image.asset('assets/icons/verify_icon.png'),
                ),
                verticalSpace(20),
                Text(
                  'Airtime Purchased Successfully',
                  style: AppTextStyles.font16.copyWith(
                    color: AppColors.mainTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(12),
                Text(
                  'Airtime of N${amount} has been successfully sent to',
                  style: AppTextStyles.font14.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '$number',
                  style: AppTextStyles.font14.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(84),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48.h,
                      width: 155.w,
                      child: ButtonWidget(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        text: 'Auto Renewal',
                        textColor: AppColors.primaryColor,
                        onTap: () => nextScreen(
                            context,
                            AirtimeAutoRenewalScreen(
                              amount: amount,
                              phoneNumber: number,
                              productCodes: productCodes,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 48.h,
                      width: 165.w,
                      child: ButtonWidget(
                        color: Colors.transparent,
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        text: 'Save beneficiary',
                        textColor: AppColors.primaryColor,
                        onTap: () => nextScreen(
                            context,
                            SaveBeneficiaryScreen(
                              phoneNumber: number,
                            )),
                      ),
                    ),
                  ],
                ),
                verticalSpace(28),
                ButtonWidget(
                  text: 'Continue',
                  onTap: () async {
                    await reloadData.reloadUserData();

                    nextScreenReplace(context, DashBoardScreen());
                  },
                ),
              ],
            ),
          )),
        ),
      );
    });
  }
}
