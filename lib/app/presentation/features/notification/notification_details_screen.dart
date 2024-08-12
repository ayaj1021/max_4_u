import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/model/notification_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/components/transaction_details_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key, required this.notificationResponseData});
final NotificationResponseData notificationResponseData;
  @override
  Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  horizontalSpace(85),
                   Text(
                    'Notification details',
                    style: AppTextStyles.font18,
                  ),
                ],
              ),
              verticalSpace(27),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
               // height: 438.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.whiteColor,
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: 24,
                      //   width: 24,
                      //   child: Image.asset('assets/logo/mtn_logo.png'),
                      // ),
                      horizontalSpace(5),
                       Text(
                        '${notificationResponseData.transactions?.first.heading}',
                        style: AppTextStyles.font14,
                      )
                    ],
                  ),
                  verticalSpace(16),
                   Text(
                    '-#35,000.00',
                    style: AppTextStyles.font20,
                  ),
                  verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: Image.asset('assets/icons/success_icon.png'),
                      ),
                      horizontalSpace(5),
                      Text(
                        'Successful',
                        style:
                            AppTextStyles.font12.copyWith(color: Colors.green),
                      )
                    ],
                  ),
                  verticalSpace(46),
                  const TransactionDetailsSection(
                    title: 'Recipient',
                    value: '08169784011',
                  ),
                  verticalSpace(24),
                  const Row(
                    children: [
                      TransactionDetailsSection(
                        title: 'Transaction ID',
                        value: '7809767313589100',
                        iconData: Icons.copy,
                      ),
                    ],
                  ),
                  verticalSpace(24),
                  const TransactionDetailsSection(
                    title: 'Transaction Type',
                    value: 'Airtime',
                  ),
                  verticalSpace(24),
                  const TransactionDetailsSection(
                    title: 'Transaction Means',
                    value: 'Wallet',
                  ),
                  verticalSpace(24),
                  const TransactionDetailsSection(
                    title: 'Payment method',
                    value: 'Wallet',
                  ),
                  verticalSpace(24),
                  const TransactionDetailsSection(
                    title: 'Date',
                    value: 'Apr 18th,2024 20:59ß',
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
                     Text(
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
              verticalSpace(50),
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
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/icons/cancel_icon.png',
                        ),
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
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          'assets/icons/cancel_icon.png',
                                        ),
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
                                      child:  Text(
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
