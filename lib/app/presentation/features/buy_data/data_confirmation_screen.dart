import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/presentation/save_beneficiary_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_data/buy_data_auto_renewal_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/sell_airtime_data/save_customer_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';

class DataConfirmationScreen extends StatelessWidget {
  const DataConfirmationScreen(
      {super.key,
      required this.amount,
      required this.phoneNumber,
      required this.productCodes,
      required this.userType});
  final String amount;
  final String phoneNumber;
  final String productCodes;
  final String userType;

  @override
  Widget build(BuildContext context) {
    String originalString = productCodes;
    String bundle = originalString.replaceAll('_', ' ');

    return Scaffold(
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
              'Data Purchased Successfully',
              style: AppTextStyles.font16.copyWith(
                color: AppColors.mainTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            verticalSpace(12),
            Text(
              'Data of $bundle has been successfully \nsent to',
              style: AppTextStyles.font14.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              phoneNumber,
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
                        BuyDataAutoRenewalScreen(
                          amount: amount,
                          phoneNumber: phoneNumber,
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
                    text: userType == 'user'
                        ? 'Save beneficiary'
                        : 'Save Customer',
                    textColor: AppColors.primaryColor,
                    onTap: () => nextScreen(
                        context,
                        userType == 'user'
                            ? SaveBeneficiaryScreen(
                                phoneNumber: phoneNumber,
                              )
                            : SaveCustomerScreen(
                                phoneNumber: phoneNumber,
                              )),
                  ),
                ),
              ],
            ),
            verticalSpace(28),
            ButtonWidget(
                text: 'Continue',
                onTap: () async {
                  nextScreenReplace(context, DashBoardScreen());
                }),
          ],
        ),
      )),
    );
  }
}
