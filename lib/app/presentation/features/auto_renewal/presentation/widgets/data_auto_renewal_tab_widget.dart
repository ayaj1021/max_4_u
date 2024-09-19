import 'package:flutter/material.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/auto_renewal_screen.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/widgets/cancel_auto_renewal_alert_dialog.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/provider/cancel_auto_renewal_provider.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class DataAutoRenewalTabWidget extends StatelessWidget {
  const DataAutoRenewalTabWidget({
    super.key,
    required this.data,
    required this.index,
    required this.cancelRenewal,
  });

  final int index;
  final CancelAutoRenewalProvider cancelRenewal;

  final List<AutoRenewalData> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      //   height: 174.h,
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
                    '${data[index].number}',
                    // '${data.number}',
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
                    '${data[index].serviceName}'.toUpperCase(),
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                  // Text(
                  //   '${data.id}'.toUpperCase(),
                  //   style: AppTextStyles.font16.copyWith(
                  //     fontWeight: FontWeight.w500,
                  //     color: AppColors.mainTextColor,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          verticalSpace(13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Column(
              //   crossAxisAlignment:
              //       CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Amount',
              //       style:
              //           AppTextStyles.font12.copyWith(
              //         fontWeight: FontWeight.w400,
              //         color: AppColors.textColor,
              //       ),
              //     ),
              //     Text(
              //       '${data[index].amount}',
              //       style:
              //           AppTextStyles.font16.copyWith(
              //         fontWeight: FontWeight.w500,
              //         color: AppColors.mainTextColor,
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Bundle',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  Text(
                    '${data[index].productCode}'.toUpperCase(),
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(8),
          ButtonWidget(
            onTap: () async {
              // CancelAutoRenewalAlertDialog();
              cancelAutoRenewalAlertBox(context, () async {
                Navigator.pop(context);

                await cancelRenewal.cancelAutoRenewal(
                  id: '${data[index].id}',
                  // id: '${data.map((e)=> e.id)}',
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
              });
            },
            text: 'Cancel auto renewal',
            textColor: AppColors.primaryColor,
            color: Color(0xffD9D9D9),
          ),
        ],
      ),
    );
  }
}
