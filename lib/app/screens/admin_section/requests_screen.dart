import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/admin_section/components/approved_component.dart';
import 'package:max_4_u/app/screens/admin_section/components/denied_component.dart';
import 'package:max_4_u/app/screens/admin_section/components/pending_component.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:  Text(
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
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 38.h,
                                width: 345.w,
                                alignment: Alignment.center,
                                //  padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                  color: Color(0xffDADBDD),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TabBar(
                                  indicator: BoxDecoration(
                                      color: const Color(0xffB0D3EB),
                                      borderRadius: BorderRadius.circular(6)),
                                  controller: _tabController,
                                  indicatorColor: Colors.transparent,
                                  labelColor: AppColors.blackColor,
                                  tabs: [
                                    Container(
                                      height: 31.h,
                                      width: 94.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Pending'),
                                          horizontalSpace(7),
                                          Container(
                                            height: 12.h,
                                            width: 17.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                color: AppColors.subTextColor),
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalPending}',
                                              //  '${getAllAppUsers.allAppUsers.totalConsumer}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 31.h,
                                      width: 94.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Approved'),
                                          horizontalSpace(4),
                                          Container(
                                            height: 12.h,
                                            width: 17.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                color: AppColors.subTextColor),
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalConfirmed}',
                                              // '${getAllAppUsers.allAppUsers.totalVendor}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          AppColors.whiteColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 31.h,
                                      width: 94.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text('Denied'),
                                          horizontalSpace(7),
                                          Container(
                                            height: 12.h,
                                            width: 17.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                color: AppColors.subTextColor),
                                            child: Text(
                                              '${getAllVendorRequest.allVendorRequest.totalIncomplete}',
                                              style: AppTextStyles.font12
                                                  .copyWith(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
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
