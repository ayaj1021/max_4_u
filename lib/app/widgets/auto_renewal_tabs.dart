import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/cancel_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/auto_renewal/auto_renewal_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AutoRenewalTabs extends StatelessWidget {
  const AutoRenewalTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<ReloadUserDataProvider, CancelAutoRenewalProvider>(
        builder: (context, reloadData, cancelRenewal, _) {
      final data = reloadData.loadData.autoRenewal!.data![0];
      return Container(
        height: 174.h,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xffE8E8E8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
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
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      '${data.number}',
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Network',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      '${data.serviceName}'.toUpperCase(),
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      '${data.amount}',
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                  ],
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       'Data Bundle',
                //       style: AppTextStyles.font12.copyWith(
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.textColor,
                //       ),
                //     ),
                //     Text(
                //       '${data.productCode}',
                //       style: AppTextStyles.font16.copyWith(
                //         fontWeight: FontWeight.w500,
                //         color: AppColors.mainTextColor,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            verticalSpace(8),
            ButtonWidget(
              onTap: () async {
                await cancelRenewal.cancelAutoRenewal(
                  id: '${data.id}',
                );

                if (cancelRenewal.status == false && context.mounted) {
                  showMessage(
                    context,
                    cancelRenewal.message,
                    isError: true,
                  );

                  return;
                }

                if (cancelRenewal.status == true && context.mounted) {
                  showMessage(
                    context,
                    cancelRenewal.message,
                    // isError: false,
                  );
                  nextScreenReplace(context, AutoRenewalScreen());
                }
              },
              text:  cancelRenewal.state == ViewState.Busy ? 'Cancelling auto renewal' : 'Cancel auto renewal',
              textColor: AppColors.primaryColor,
              color: Color(0xffD9D9D9),
            )
          ],
        ),
      );
    });
  }
}
