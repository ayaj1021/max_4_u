import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/get_notification_provider.dart';
import 'package:max_4_u/app/screens/notification/components/transaction_details_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetNotificationProvider>(context, listen: false)
          .getAllNotification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetNotificationProvider>(builder: (context, getNot, _) {
      return BusyOverlay(
        show: getNot.state == ViewState.Busy,
        title: getNot.message,
        child: Scaffold(
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
                      horizontalSpace(99),
                      Text(
                        'Notifications',
                        style: AppTextStyles.font18,
                      )
                    ],
                  ),
                  verticalSpace(32),
                  getNot.allNotifications.transactions == null
                      ? SizedBox.shrink()
                      : getNot.allNotifications.transactions!.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 92.h,
                                    width: 92.w,
                                    child: Image.asset(
                                        'assets/images/no_beneficiary_image.png')),
                                verticalSpace(24),
                                Text(
                                  'You have no notification yet',
                                  style: AppTextStyles.font14.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Column(
                                  children: List.generate(
                                      getNot.allNotifications.transactions!
                                          .length, (index) {
                                    final data = getNot
                                        .allNotifications.transactions![index];
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          // onTap: () => nextScreen(context,
                                          //     const NotificationDetailsScreen()),
                                          child: TransactionDetailComponent(
                                            isSuccess: false,
                                            heading: '${data.heading}',
                                            message: '${data.message}',
                                          ),
                                        ),
                                        verticalSpace(12),
                                      ],
                                    );
                                  }),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Text(
                                //       'Today',
                                //       style: AppTextStyles.font14.copyWith(
                                //         fontWeight: FontWeight.w600,
                                //         color: const Color(0xff333333),
                                //       ),
                                //     ),
                                //     Text(
                                //       'Mark as read',
                                //       style: AppTextStyles.font14.copyWith(
                                //         fontSize: 11,
                                //         fontWeight: FontWeight.w600,
                                //         color: AppColors.secondaryColor,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
