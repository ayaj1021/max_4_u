import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/approved_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/denied_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/pending_component.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_vendors_requests_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllVendorRequestsProvider>(context, listen: false)
          .getAllVendorsRequests();
    });

    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllVendorRequestsProvider>(
        builder: (context, getAllVendorRequest, _) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Requests',
                      style: AppTextStyles.font18,
                    ),
                  ),
                  verticalSpace(29),
                  getAllVendorRequest.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 45.h,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                //  padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  color: Color(0xffDADBDD),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TabBar(
                                  
                                  padding: EdgeInsets.zero,
                                  dividerHeight: 0,
                                  indicator: BoxDecoration(
                                      color: const Color(0xffB0D3EB),
                                      borderRadius: BorderRadius.circular(6)),
                                  controller: _tabController,
                                  indicatorColor: Colors.transparent,
                                  labelColor: AppColors.blackColor,
                                 // labelPadding: EdgeInsets.symmetric(horizontal:  13),
                                  tabs: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                           // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Pending',
                                              style:
                                                  AppTextStyles.font10.copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          horizontalSpace(7),
                                          CircleAvatar(
                                            radius: 9,
                                            backgroundColor:
                                                AppColors.subTextColor,
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalPending}',
                                              //  '${getAllAppUsers.allAppUsers.totalConsumer}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Text(
                                            'Approved',
                                            style: AppTextStyles.font10.copyWith(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                          horizontalSpace(4),
                                          CircleAvatar(
                                            radius: 9,
                                            backgroundColor:
                                                AppColors.subTextColor,
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalConfirmed}',
                                              // '${getAllAppUsers.allAppUsers.totalVendor}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Denied',
                                              style:
                                                  AppTextStyles.font10.copyWith(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          //horizontalSpace(7),
                                          CircleAvatar(
                                            radius: 9,
                                            //height: 12.h,
                                            backgroundColor:
                                                AppColors.subTextColor,
                                      
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalDenied}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w500,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(23),
                              Expanded(
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    PendingComponent(),
                                    ApprovedComponent(),
                                    DeniedComponent()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
