import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/widgets/airtime_auto_renewal_tab_widget.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/provider/cancel_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class AirtimeAutoRenewalPage extends StatelessWidget {
  const AirtimeAutoRenewalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ReloadUserDataProvider, CancelAutoRenewalProvider>(
        builder: (context, reloadData, cancelRenewal, _) {
      return Stack(
        children: [
          Column(
            children: [
              verticalSpace(reloadData.loadData.autoRenewal!.data!
                      .where((element) => element.category == 'airtime')
                      .isEmpty
                  ? 250
                  : 30),
              reloadData.loadData.autoRenewal!.data!
                      .where((element) => element.category == 'airtime')
                      .isEmpty
                  ? Center(
                      child: SizedBox(
                        // height: 108.h,
                        width: 300.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                //  height: 56.h,
                                width: 56.w,
                                child: Image.asset(
                                    'assets/images/no_request_image.png')),
                            verticalSpace(10),
                            Text(
                              'No transaction set to auto renewals. Buy airtime and set to auto renewals.',
                              style: AppTextStyles.font14.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: List.generate(
                          reloadData.loadData.autoRenewal!.data!
                              .where((element) => element.category == 'airtime')
                              .length, (index) {
                        final data = reloadData.loadData.autoRenewal!.data!
                            .where((element) => element.category == 'airtime')
                            .map((e) => e)
                            .toList();
                        return Column(
                          children: [
                            AirtimeAutoRenewalTab(
                              data: data,
                              index: index,
                              cancelRenewal: cancelRenewal,
                            ),
                            verticalSpace(20),
                          ],
                        );
                      }),
                    ),
            ],
          ),
          cancelRenewal.state == ViewState.Busy
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xffE8E8E8).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      );
    });
  }
}
