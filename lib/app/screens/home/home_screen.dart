import 'package:flutter/material.dart';
import 'package:max_4_u/app/provider/vendor_check_provider.dart';
import 'package:max_4_u/app/screens/buy_airtime/buy_airtime_screen.dart';
import 'package:max_4_u/app/screens/buy_data/buy_data_screen.dart';
import 'package:max_4_u/app/screens/drawer/drawer.dart';
import 'package:max_4_u/app/screens/home/component/account_balance_component.dart';
import 'package:max_4_u/app/screens/home/component/overview_container.dart';
import 'package:max_4_u/app/screens/home/component/service_component.dart';
import 'package:max_4_u/app/screens/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/screens/notification/notification_screen.dart';
import 'package:max_4_u/app/screens/transaction/transaction_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: SizedBox(
        //   height: 21.h,
        //   width: 29.w,
        //   child: GestureDetector(
        //     child: Image.asset(
        //       'assets/icons/side_bar_icon.png',
        //       scale: 4,
        //     ),
        //   ),
        // ),
        title: Text(
          'Hello, Praise',
          style: AppTextStyles.font18.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
                onTap: () => nextScreen(context, const NotificationScreen()),
                child: const Icon(Icons.notifications_outlined)),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<VendorCheckProvider>(builder: (context, vendor, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AccountBalanceWidget(),
                  verticalSpace(40),
                  Text(
                    'Services',
                    style: AppTextStyles.font18.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  verticalSpace(16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => nextScreen(
                              context,
                              const BuyAirtimeScreen(),
                            ),
                            child: const ServiceComponent(
                              serviceColor: Color(0xffDEEDF7),
                              serviceName: 'Airtime\npurchase',
                              serviceIcon: Icons.call_outlined,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => nextScreen(
                              context,
                              const BuyDataScreen(),
                            ),
                            child: const ServiceComponent(
                              serviceColor: Color(0xffE8D6FE),
                              serviceName: 'Data\npurchase',
                              serviceIcon: Icons.network_wifi_outlined,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(vendor.isVendor ? 16 : 0),
                      vendor.isVendor
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => nextScreen(
                                    context,
                                    const BuyAirtimeScreen(),
                                  ),
                                  child: const ServiceComponent(
                                    serviceColor: Color(0xffDEEDF7),
                                    serviceName: 'Airtime\npurchase',
                                    serviceIcon: Icons.call_outlined,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => nextScreen(
                                    context,
                                    const BuyDataScreen(),
                                  ),
                                  child: const ServiceComponent(
                                    serviceColor: Color(0xffE8D6FE),
                                    serviceName: 'Data\npurchase',
                                    serviceIcon: Icons.network_wifi_outlined,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                  verticalSpace(40),
                  vendor.isVendor
                      ? Text(
                          'Overview',
                          style: AppTextStyles.font18.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transaction history',
                              style: AppTextStyles.font18.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => nextScreen(
                                  context, const TransactionScreen()),
                              child: Text(
                                'see all',
                                style: AppTextStyles.font18.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppColors.secondaryColor),
                              ),
                            ),
                          ],
                        ),
                  verticalSpace(17),
                  vendor.isVendor
                      ? const OverViewContainer()
                      : const TransactionHistoryContainer()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
