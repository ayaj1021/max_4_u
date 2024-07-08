import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/airtime_auto_renewal_page.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/data_autorenewal_page.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class AutoRenewalScreen extends StatefulWidget {
  const AutoRenewalScreen({super.key});

  @override
  State<AutoRenewalScreen> createState() => _AutoRenewalScreenState();
}

class _AutoRenewalScreenState extends State<AutoRenewalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isTapped = false;

  @override
  void initState() {
    getAllAutoRenewals();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List autoRenewals = [];

  getAllAutoRenewals() async {
    final renewals = await SecureStorage().getUserAutoRenewal();
    setState(() {
      autoRenewals = renewals;
    });

    return renewals;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProviderImpl, ReloadUserDataProvider>(
        builder: (context, authProv, reloadData, _) {
      return Scaffold(
        body: SafeArea(
            child: BusyOverlay(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  nextScreenReplace(context, DashBoardScreen()),
                              child: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            horizontalSpace(101),
                            Text(
                              'Auto Renewals',
                              style: AppTextStyles.font18,
                            ),
                            // GestureDetector(
                            //     onTap: () {
                            //       setState(() {
                            //         isTapped = !isTapped;
                            //       });
                            //     },
                            //     child: const Icon(Icons.more_vert))
                          ],
                        ),
                        verticalSpace(43),
                        Container(
                            height: 40.h,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffDADBDD),
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: Color(0xffAED1E8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              controller: _tabController,
                              tabs: [
                                Container(
                                  height: 38.h,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Data',
                                    style: AppTextStyles.font12.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor),
                                  ),
                                ),
                                Container(
                                  height: 38.h,
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Airtime',
                                    style: AppTextStyles.font12.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textColor),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          child: TabBarView(
                              controller: _tabController,
                              children: [
                                DataAutoRenewalPage(),
                                AirtimeAutoRenewalPage()
                              ]),
                        ),
                      ],
                    ),
                    isTapped
                        ? Positioned(
                            right: 0,
                            top: 30,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            height: 197.h,
                                            width: 356.w,
                                            // MediaQuery.of(context).size.width,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 17, horizontal: 15),
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(children: [
                                              Text(
                                                'Cancel Auto Renewal',
                                                style:
                                                    AppTextStyles.font18.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.subTextColor,
                                                ),
                                              ),
                                              verticalSpace(15),
                                              Text(
                                                'You will not get this package monthly. Are you sure you want to cancel auto renewal?',
                                                style:
                                                    AppTextStyles.font14.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.textColor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              verticalSpace(25),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: 44.h,
                                                    width: 117.w,
                                                    child: ButtonWidget(
                                                      text: 'Yes, proceed',
                                                      color:
                                                          const Color(0xff219653),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              contentPadding:
                                                                  EdgeInsets.zero,
                                                              content: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            17,
                                                                        horizontal:
                                                                            23),
                                                                height: 207.h,
                                                                width:
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          67.h,
                                                                      width: 67.w,
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/icons/verify_icon.png'),
                                                                    ),
                                                                    verticalSpace(
                                                                        10),
                                                                    Text(
                                                                      'Canceled Successfully',
                                                                      style: AppTextStyles
                                                                          .font16
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .mainTextColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                      ),
                                                                    ),
                                                                    verticalSpace(
                                                                        13),
                                                                    Text(
                                                                      'Auto renewal has been canceled successfully.',
                                                                      style: AppTextStyles
                                                                          .font14
                                                                          .copyWith(
                                                                        color: AppColors
                                                                            .textColor,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 44.h,
                                                    width: 117.w,
                                                    child: ButtonWidget(
                                                      text: 'No, cancel',
                                                      color:
                                                          const Color(0xffF2C94C),
                                                      onTap: () =>
                                                          Navigator.pop(context),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ]),
                                          ));
                                    });
                              },
                              child: Container(
                                height: 54.h,
                                width: 193.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Cancel all auto renewals',
                                  style: AppTextStyles.font14.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTextColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            )),
      );
    });
  }
}
