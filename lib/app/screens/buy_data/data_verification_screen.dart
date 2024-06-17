import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/buy_data_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/screens/confirmation/confirmation_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/helper.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class DataVerificationScreen extends StatefulWidget {
  const DataVerificationScreen(
      {super.key,
      required this.network,
      required this.amount,
      required this.phoneNumber,
      required this.dataBundle});
  final String network;
  final String amount;
  final String phoneNumber;
  final String dataBundle;

  @override
  State<DataVerificationScreen> createState() => _DataVerificationScreenState();
}

class _DataVerificationScreenState extends State<DataVerificationScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          // Ensure end date is after start date
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _selectedValidity = dataValidityProvider[0];
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return Consumer3<BuyDataProvider, ObscureTextProvider,
        ActivateAutoRenewalProvider>(
      builder: (context, buyData, obscure, activateRenewal, _) {
        return BusyOverlay(
          show: buyData.state == ViewState.Busy,
          title: buyData.message,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
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
                    verticalSpace(52),
                    Text(
                      'Send data to',
                      style: AppTextStyles.font14.copyWith(
                        color: const Color(0xff475569),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(4),
                    Container(
                      padding: const EdgeInsets.all(13),
                      height: 125.h,
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
                                    widget.network,
                                    style: AppTextStyles.font16.copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          verticalSpace(12),
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
                                    widget.dataBundle,
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
                                    widget.dataBundle,
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
                    Row(
                      children: [
                        Checkbox(
                            activeColor: AppColors.primaryColor,
                            checkColor: AppColors.overlayColor,
                            value: obscure.isObscure,
                            onChanged: (v) {
                              obscure.changeObscure();
                            }),
                        Text('Enable auto-renewal for this transaction',
                            style: AppTextStyles.font14.copyWith(
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    obscure.isObscure
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // verticalSpace(24),
                              Text(
                                'Frequency',
                                style: AppTextStyles.font14.copyWith(
                                  color: const Color(0xff475569),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              verticalSpace(4),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: 52.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: const Color(0xffCBD5E1),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(12),
                                  underline: const SizedBox(),
                                  value: _selectedValidity,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedValidity = newValue!;
                                    });
                                  },
                                  items: dataValidityProvider
                                      .map((String dataValidity) {
                                    return DropdownMenuItem(
                                      value: dataValidity,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 250),
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          child: Text(
                                            dataValidity.toUpperCase(),
                                            style:
                                                AppTextStyles.font14.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),

                              verticalSpace(31),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ValidityDateWidget(
                                      onTap: () => _selectDate(context, true),
                                      date:
                                          '${_startDate != null ? dateFormat.format(_startDate!) : 'DD-MM-YY'}',
                                      dateLabel: 'Start Date',
                                    ),
                                    ValidityDateWidget(
                                      onTap: () => _selectDate(context, false),
                                      date:
                                          '${_endDate != null ? dateFormat.format(_endDate!) : 'DD-MM-YY'}',
                                      dateLabel: 'End Date',
                                    )
                                  ]),
                            ],
                          )
                        : SizedBox(),
                    verticalSpace(146),
                    ButtonWidget(
                      text: 'Send data',
                      onTap: () async {
                        final productCodes = await ProductHelper()
                            .getDataProducts(widget.network);
                        log('This is the code ${productCodes.toString()}');

                        await activateRenewal.activateAutoRenewal(
                          phoneNumber: widget.phoneNumber,
                          productCode: productCodes,
                          amount: widget.amount,
                          // startDate: _startDate!,
                          // endDate: _endDate!,
                          intervalDaily: _selectedValidity,
                        );

                        await buyData.buyData(
                          phoneNumber: widget.phoneNumber,
                          amount: widget.amount,
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
                            // isError: false,
                          );

                          nextScreen(
                              context,
                              ConfirmationScreen(
                                amount: widget.amount,
                                number: widget.phoneNumber,
                              ));
                        }
                      },
                    )
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

class ValidityDateWidget extends StatelessWidget {
  const ValidityDateWidget({
    super.key,
    required this.date,
    this.onTap,
    required this.dateLabel,
  });

  final String date;
  final String dateLabel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        dateLabel,
        style: AppTextStyles.font14.copyWith(
          color: const Color(0xff475569),
          fontWeight: FontWeight.w500,
        ),
      ),
      verticalSpace(8),
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 52.h,
          width: 119.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Color(0xffBDBDBD),
            ),
          ),
          child: Text(
            date,
            style: AppTextStyles.font14.copyWith(
              color: const Color(0xffAAA3A3),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      )
    ]);
  }
}
