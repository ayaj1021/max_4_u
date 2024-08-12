import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/buy_data/presentation/buy_data_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_data/data_confirmation_screen.dart';
import 'package:max_4_u/app/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/presentation/features/buy_data/provider/buy_data_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/helper.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class DataVerificationScreen extends StatefulWidget {
  const DataVerificationScreen(
      {super.key,
      required this.network,
      required this.amount,
      required this.phoneNumber,
      required this.dataBundle, required this.userType});
  final String network;
  final String amount;
  final String phoneNumber;
  final String dataBundle;
  final String userType;

  @override
  State<DataVerificationScreen> createState() => _DataVerificationScreenState();
}

class _DataVerificationScreenState extends State<DataVerificationScreen> {
  // DateTime? _startDate;
  // DateTime? _endDate;

  // Future<void> _selectDate(BuildContext context, bool isStartDate) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now().add(Duration(days: 1)),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2101),
  //   );

  //   if (pickedDate != null) {
  //     DateTime now = DateTime.now();
  //     DateTime pickedDateTime = DateTime(
  //       pickedDate.year,
  //       pickedDate.month,
  //       pickedDate.day,
  //       now.hour,
  //       now.minute + 1, // Add one minute to the current time
  //     );

  //     setState(() {
  //       if (isStartDate) {
  //         _startDate = pickedDateTime;
  //         // Ensure end date is after start date
  //         if (_endDate != null && _endDate!.isBefore(_startDate!)) {
  //           _endDate = null;
  //         }
  //       } else {
  //         _endDate = pickedDateTime;
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //  List<String> network = widget.network.split('.');

    // List<String> bundle = widget.dataBundle.split(' - ');
    List<String> parts = widget.dataBundle.split(' - ');
    //String bundle = '${parts[0]} }';
    // String amount = bundle.last;
    String dataBundleType = parts.last;
    // String amount = parts.last;

    String originalString = dataBundleType;
    String bundle = originalString.replaceAll('_', ' ');

    // List<String> data = amount.split(' ');
    // String dataAmount = data.last.trim();

    return Consumer3<BuyDataProvider, AutoRenewalCheck,
        ActivateAutoRenewalProvider>(
      builder: (context, buyData, autoRenewalCheck, activateRenewal, _) {
        return BusyOverlay(
          show: buyData.state == ViewState.Busy,
          title: buyData.message,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => nextScreen(context, BuyDataScreen()),
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
                    verticalSpace(50),
                    Text(
                      'Send data to',
                      style: AppTextStyles.font18.copyWith(
                        color: const Color(0xff475569),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(14),
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
                                  Text(
                                    widget.phoneNumber,
                                    style: AppTextStyles.font16.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
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
                                  )
                                ],
                              )
                            ],
                          ),
                          verticalSpace(55),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                  Text(
                                    'N${widget.amount}',
                                    style: AppTextStyles.font16.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Data bundle',
                                    style: AppTextStyles.font12.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    bundle.toString(),
                                    //bundle[0],
                                    style: AppTextStyles.font16.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    verticalSpace(361),
                    ButtonWidget(
                        text: 'Send data',
                        onTap: () async {
                          final productCodes = await ProductHelper()
                              .getDataProducts(widget.dataBundle);
                          //.getDataProducts(widget.network);
                          log('This is the code ${productCodes.toString()}');

                          await buyData.buyData(
                            phoneNumber: widget.phoneNumber,
                            productCode: productCodes,
                          );

                          if (buyData.status == false && context.mounted) {
                            showMessage(
                              context,
                              buyData.message,
                              isError: true,
                            );
                            log(buyData.message.toString());
                            return;
                          }

                          if (buyData.status == true && context.mounted) {
                            showMessage(
                              context,
                              buyData.message,
                            );

                            nextScreen(
                                context,
                                DataConfirmationScreen(
                                  amount: widget.amount,
                                  phoneNumber: widget.phoneNumber,
                                  productCodes: productCodes, userType: widget.userType,
                                ));
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
