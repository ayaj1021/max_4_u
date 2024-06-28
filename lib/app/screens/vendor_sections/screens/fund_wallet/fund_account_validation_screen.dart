import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/fund_account_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class FundAccountValidationScreen extends StatefulWidget {
  const FundAccountValidationScreen({super.key, required this.token});
  final String token;

  @override
  State<FundAccountValidationScreen> createState() =>
      _FundAccountValidationScreenState();
}

class _FundAccountValidationScreenState
    extends State<FundAccountValidationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FundAccountProvider>(context, listen: false)
          .verifyPayment(paymentToken: widget.token, context: context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<FundAccountProvider, ReloadUserDataProvider>(
        builder: (context, fundAcct, reloadData, _) {
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                fundAcct.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      )
                    : Container(
                        height: 253.h,
                        width: 343.w,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 67.h,
                              width: 67.w,
                              child:
                                  Image.asset('assets/images/verify_image.png'),
                            ),
                            verticalSpace(20),
                            Text(
                              fundAcct.message,
                              style: AppTextStyles.font20.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          
                           
                            verticalSpace(20),
                            ButtonWidget(
                              text: 'Continue',
                              onTap: ()async { 
                                await reloadData.reloadUserData();
                                nextScreenReplace(context, DashBoardScreen());}
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        )),
      );
    });
  }
}
