import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/airtime_auto_renewal_page.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/data_autorenewal_page.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/widgets/cancel_auto_renewal_alert_dialog.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
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
      autoRenewals = renewals ?? [];
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
                              dividerHeight: 0,
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
                        ? CancelAutoRenewalAlertDialog()
                        : const SizedBox()
                  ],
                ),
              ),
            )),
      );
    });
  }
}

