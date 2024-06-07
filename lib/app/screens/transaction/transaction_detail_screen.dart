import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/screens/transaction/components/transaction_details_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen(
      {super.key,
      required this.amount,
      required this.referenceId,
      required this.status, required this.date, required this.type});
  final String amount;
  final String referenceId;
  final String status;
   final String date;
   final String type;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);
     DateFormat dateFormat = DateFormat('MMMM d, yyyy h:mm a'); 
      String formattedDate = dateFormat.format(dateTime);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor2,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Row(
                children: [
                  BackArrowButton(
                    onTap: () => Navigator.pop(context),
                  ),
                  horizontalSpace(120),
                  const Text(
                    'Details',
                    style: AppTextStyles.font18,
                  ),
                ],
              ),
              verticalSpace(27),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                height: 438.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(
                  //       height: 24,
                  //       width: 24,
                  //       child: Image.asset('assets/logo/mtn_logo.png'),
                  //     ),
                  //     horizontalSpace(5),
                  //     const Text(
                  //       'MTN',
                  //       style: AppTextStyles.font14,
                  //     )
                  //   ],
                  // ),
                  verticalSpace(16),
                  Text(
                    'N$amount',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: status == 'success'
                            ? Image.asset('assets/icons/success_icon.png')
                            : SizedBox.shrink(),
                      ),
                      horizontalSpace(5),
                      Text(
                        '$status',
                        style: AppTextStyles.font12.copyWith(
                            color: status == 'success'
                                ? Colors.green
                                : status == 'pending'
                                    ? Color(0xffA6B309)
                                    : Colors.red),
                      )
                    ],
                  ),
                  verticalSpace(46),
                  // const TransactionDetailsSection(
                  //   title: 'Recipient',
                  //   value: '08169784011',
                  // ),
                  // verticalSpace(24),
                  Row(
                    children: [
                      TransactionDetailsSection(
                        title: 'Transaction ID',
                        value: '$referenceId',
                        iconData: Icons.copy,
                      ),
                    ],
                  ),
                  verticalSpace(24),
                   TransactionDetailsSection(
                    title: 'Transaction Type',
                    value: '$type',
                  ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Transaction Means',
                  //   value: 'Wallet',
                  // ),
                  // verticalSpace(24),
                  // const TransactionDetailsSection(
                  //   title: 'Payment method',
                  //   value: 'Wallet',
                  // ),
                  verticalSpace(24),
                   TransactionDetailsSection(
                    title: 'Date',
                    value: '$formattedDate',
                  ),
                ]),
              ),
              verticalSpace(20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                height: 88.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Any issue with this transaction?',
                      style: AppTextStyles.font14,
                    ),
                    verticalSpace(5),
                    Row(
                      children: [
                        const Icon(
                          Icons.support_agent_outlined,
                          color: AppColors.primaryColor,
                        ),
                        horizontalSpace(12),
                        Text(
                          'Contact customer service',
                          style: AppTextStyles.font14
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(100),
              ButtonWidget(
                text: 'Get Receipt',
                onTap: () {
                  getReceiptBottomSheet(context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<dynamic> getReceiptBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 186.h,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                color: AppColors.whiteColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 21),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'X',
                        style: AppTextStyles.font20,
                      ),
                    ),
                  ),
                ),
                verticalSpace(18),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 186.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                color: AppColors.whiteColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 21),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: SizedBox(
                                          height: 16,
                                          width: 16,
                                          child: Image.asset(
                                              'assets/icons/cancel_icon.png'),
                                        )),
                                  ),
                                ),
                                verticalSpace(18),
                                Text(
                                  'PDF',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                  ),
                                ),
                                verticalSpace(15),
                                Divider(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                ),
                                verticalSpace(15),
                                Text(
                                  'Image',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.download_outlined,
                        color: Color(0xff333333),
                      ),
                      horizontalSpace(12),
                      Text(
                        'Download Receipt',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(15),
                Divider(
                  color: AppColors.blackColor.withOpacity(0.1),
                ),
                verticalSpace(15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 186.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                color: AppColors.whiteColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 21),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: const Text(
                                        'X',
                                        style: AppTextStyles.font20,
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(18),
                                Text(
                                  'PDF',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                  ),
                                ),
                                verticalSpace(15),
                                Divider(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                ),
                                verticalSpace(15),
                                Text(
                                  'Image',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.ios_share_outlined,
                        color: Color(0xff333333),
                      ),
                      horizontalSpace(12),
                      Text(
                        'Share Receipt',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
