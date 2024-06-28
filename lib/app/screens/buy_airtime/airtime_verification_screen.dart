import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/data_period_enum.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/screens/buy_airtime/airtime_confirmation_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/helper.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AirtimeVerificationScreen extends StatefulWidget {
  const AirtimeVerificationScreen({
    super.key,
    required this.network,
    required this.amount,
    required this.phoneNumber,
  });

  final String network;
  final String amount;
  final String phoneNumber;

  @override
  State<AirtimeVerificationScreen> createState() =>
      _AirtimeVerificationScreenState();
}

class _AirtimeVerificationScreenState extends State<AirtimeVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    //DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Consumer<BuyAirtimeProvider>(
      builder: (context, buyAirtime, _) {
        return BusyOverlay(
          show: buyAirtime.state == ViewState.Busy,
          title: buyAirtime.message,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                          horizontalSpace(104),
                          Text(
                            'Confirmation',
                            style: AppTextStyles.font18,
                          ),
                        ],
                      ),
                      verticalSpace(30),
                      Text(
                        'Select airtime to',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      verticalSpace(4),
                      Container(
                        padding: const EdgeInsets.all(13),
                        height: 175.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone number',
                                      style: AppTextStyles.font12.copyWith(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(widget.phoneNumber,
                                        style: AppTextStyles.font16.copyWith(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.w600,
                                        ))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Network',
                                      style: AppTextStyles.font12.copyWith(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      widget.network.toUpperCase(),
                                      style: AppTextStyles.font16.copyWith(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(55),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount',
                                  style: AppTextStyles.font12.copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text('N${widget.amount}',
                                    style: AppTextStyles.font16.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),

                      //verticalSpace(28),

                      verticalSpace(331),
                      ButtonWidget(
                        text: 'Send airtime',
                        onTap: () async {
                          // final productCodes = await ProductHelper()
                          //     .getAirtimeProducts(widget.network);

                          final productCodes = await ProductHelper()
                              .getAirtimeProducts(widget.network);

                          await buyAirtime.buyAirtime(
                            phoneNumber: widget.phoneNumber,
                            amount: widget.amount,
                            productCode: productCodes,
                          );

                          if (buyAirtime.status == false && context.mounted) {
                            showMessage(
                              context,
                              buyAirtime.message,
                              isError: true,
                            );

                            return;
                          }

                          if (buyAirtime.status == true && context.mounted) {
                            showMessage(
                              context,
                              buyAirtime.message,
                              // isError: false,
                            );
                            nextScreenReplace(
                                context,
                                AirtimeConfirmationScreen(
                                  amount: widget.amount,
                                  number: widget.phoneNumber,
                                  productCodes: productCodes,
                                ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String _dataPeriodToString(DataPeriod data) {
  switch (data) {
    case DataPeriod.Daily:
      return 'Daily';
    case DataPeriod.Monthly:
      return 'Monthly';
    case DataPeriod.Weekly:
      return 'Weekly';
    case DataPeriod.Yearly:
      return 'Yearly';

    default:
      return '';
  }
}
