import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/get_all_customers_provider.dart';
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
import 'package:max_4_u/app/screens/vendor_sections/screens/sell_airtime_data/sell_airtime_screen.dart';
import 'package:max_4_u/app/screens/vendor_sections/screens/sell_airtime_data/sell_data_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String firstName = '';

  @override
  void initState() {
    getServices();
    getName();
    getUserType();
    super.initState();
  }

  String? userType;

  getUserType() async {
    final user = await SecureStorage().getUserType();
    setState(() {
      userType = user;
    });
    return user;
  }

  getName() async {
    final name = await SecureStorage().getFirstName();

    setState(() {
      firstName = name;
    });
  }

  List servicesIcon = [
    Icons.network_wifi_outlined,
    Icons.call_outlined,
  ];

  List userServices = [];

  getServices() async {
    final services = await SecureStorage().getUserServices();

    setState(() {
      userServices = services;
    });
    return services;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProviderImpl, GetAllCustomersProvider>(
        builder: (context, authProv, getCustomers, _) {
          final userFirstName = EncryptData.decryptAES('${authProv.resDataData.userData![0].firstName}');
      return Scaffold(
        drawer: const SideDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Image.asset(
                'assets/icons/side_bar_icon.png',
                scale: 4,
              ), // Replace with your image path
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          }),

          // GestureDetector(
          //   onTap: () {
          //     log('tapped');
          //     Scaffold.of(context).openDrawer();
          //   },
          //   child: SizedBox(
          //     height: 21.h,
          //     width: 29.w,
          //     child: Image.asset(
          //       'assets/icons/side_bar_icon.png',
          //       scale: 4,
          //     ),
          //   ),
          // ),
          title: Text(
            'Hello, $userFirstName',
            style: AppTextStyles.font18.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                  onTap: () {
                    nextScreen(context, const NotificationScreen());
                  },
                  child: const Icon(Icons.notifications_outlined)),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<AuthProviderImpl>(builder: (context, authProv, _) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
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
                        // ElevatedButton(
                        //     onPressed: () {
                        //       getServices();
                        //      // log('${userServices.length}');
                        //     },
                        //     child: Text('press')),
                        SizedBox(
                          height: 70.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: userServices.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  onTap: () => nextScreen(
                                    context,
                                    index == 0
                                        ? BuyDataScreen()
                                        : BuyAirtimeScreen(),
                                  ),
                                  child: ServiceComponent(
                                    margin: 20,
                                    serviceColor: Color(0xffDEEDF7),
                                    serviceName: userServices[index]
                                        ['category'],
                                    // 'Airtime\npurchase',
                                    serviceIcon: servicesIcon[index],
                                    //Icons.call_outlined,
                                  ),
                                );
                              }),
                        ),
                        verticalSpace(
                            //  vendor.isVendor == '1'
                            authProv.resDataData.userData![0].level == '1'
                                ? 0
                                : 16),
                        //    vendor.isVendor == '1'
                        authProv.resDataData.userData![0].level == '1'
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => nextScreen(
                                      context,
                                      const SellAirtimeScreen(),
                                    ),
                                    child: const ServiceComponent(
                                      serviceColor: Color(0xffDEEDF7),
                                      serviceName: 'Sell Airtime',
                                      serviceIcon: Icons.call_outlined,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => nextScreen(
                                      context,
                                      const SellDataScreen(),
                                    ),
                                    child: const ServiceComponent(
                                      serviceColor: Color(0xffE8D6FE),
                                      serviceName: 'Sell Data',
                                      serviceIcon: Icons.network_wifi_outlined,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                    verticalSpace(40),
                    //   vendor.isVendor == '1'

                    authProv.resDataData.userData![0].level == '1'
                        ? Row(
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
                          )
                        : Text(
                          'Overview',
                          style: AppTextStyles.font18.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    verticalSpace(17),
                    // vendor.isVendor == '1'
                    authProv.resDataData.userData![0].level == '1'
                        ? const TransactionHistoryContainer()
                        : const OverViewContainer(),

                    // ElevatedButton(onPressed: (){
                    //   final level =  authProv.resDataData.userData![0].level;
                    //   log('this is level: $level');
                    // }, child: Text('Get level'))
                  ],
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
