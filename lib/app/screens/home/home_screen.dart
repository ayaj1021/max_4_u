import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/drawer/drawer.dart';
import 'package:max_4_u/app/screens/home/component/account_balance_component.dart';
import 'package:max_4_u/app/screens/home/component/service_component.dart';
import 'package:max_4_u/app/screens/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox(
          height: 21.h,
          width: 29.w,
          child: GestureDetector(
            child: Image.asset(
              'assets/icons/side_bar_icon.png',
              scale: 4,
            ),
          ),
        ),
        title: Text(
          'Hello, Praise',
          style: AppTextStyles.font18.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      drawer: const SideDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ServiceComponent(
                      serviceColor: Color(0xffDEEDF7),
                      serviceName: 'Airtime\npurchase',
                      serviceIcon: Icons.call_outlined,
                    ),
                    ServiceComponent(
                      serviceColor: Color(0xffE8D6FE),
                      serviceName: 'Data\npurchase',
                      serviceIcon: Icons.network_wifi_outlined,
                    ),
                  ],
                ),
                verticalSpace(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction history',
                      style: AppTextStyles.font18.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'see all',
                      style: AppTextStyles.font18.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppColors.secondaryColor),
                    ),
                  ],
                ),
                verticalSpace(16),
                const TransactionHistoryContainer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
