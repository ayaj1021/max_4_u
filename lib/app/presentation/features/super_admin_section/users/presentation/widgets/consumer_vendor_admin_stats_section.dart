import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/admin_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/consumer_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/vendor_component.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class ConsumerVendorAdminStatsSection extends StatelessWidget {
  const ConsumerVendorAdminStatsSection({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllAppUsers, ReloadUserDataProvider>(
        builder: (context, getAllAppUsers, reloadData, child) {
      return Container(
        //height: 562.h,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Color(0xffE8E8E8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              // height: 38.h,
              width: 350.w,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: Color(0xffDADBDD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                dividerHeight: 0,
                indicator: BoxDecoration(
                    color: const Color(0xffB0D3EB),
                    borderRadius: BorderRadius.circular(6)),
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: AppColors.blackColor,
                tabs: [
                  Container(
                    // height: 31.h,
                    // width: 192.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Consumers',
                          style: AppTextStyles.font10,
                        ),
                        horizontalSpace(4),
                        Container(
                          //  height: 12.h,
                          // width: 12.w,
                          padding: EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColors.subTextColor),
                          child: Text(
                            getAllAppUsers.allAppUsers.totalConsumer == null
                                ? ''
                                : '${getAllAppUsers.allAppUsers.totalConsumer}',
                            style: AppTextStyles.font12.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // height: 31.h,
                    // width: 162.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vendors',
                          style: AppTextStyles.font10,
                        ),
                        horizontalSpace(7),
                        Container(
                          // height: 12.h,
                          width: 17.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColors.subTextColor),
                          child: Text(
                            getAllAppUsers.allAppUsers.totalVendor == null
                                ? ''
                                : '${getAllAppUsers.allAppUsers.totalVendor}',
                            style: AppTextStyles.font12.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // height: 31.h,
                    width: 162.w,
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(6)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Admins',
                          style: AppTextStyles.font12,
                        ),
                        horizontalSpace(7),
                        Container(
                          // height: 12.h,
                          width: 17.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColors.subTextColor),
                          child: Text(
                            getAllAppUsers.allAppAdmins.totalData == null
                                ? ''
                                : '${getAllAppUsers.allAppAdmins.totalData}',
                            style: AppTextStyles.font12.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColors.whiteColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            verticalSpace(23),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CustomersComponent(),
                  VendorsComponent(),
                  AdminsComponent()
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

