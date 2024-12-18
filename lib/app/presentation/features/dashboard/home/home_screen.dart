import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/account_balance_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/overview_container.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/widgets/services_section.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/transaction_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/drawer/drawer.dart';
import 'package:max_4_u/app/presentation/features/notification/notification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            AppColors.primaryColor, // Set your desired status bar color here
        statusBarIconBrightness: Brightness.light, // Set light or dark icons
      ),
    );

    super.initState();
  }

  List servicesIcon = [
    Icons.network_wifi_outlined,
    Icons.call_outlined,
  ];

  List<Service> userServices = [];

  getServices() async {
    final storage = await SecureStorage();

    final userServicesList = (await storage.getUserServices()) ?? [];
    setState(() {
      userServices = userServicesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProv = context.watch<AuthProviderImpl>();

    final reloadData = context.watch<ReloadUserDataProvider>();

    final userFirstName = EncryptData.decryptAES(
        '${authProv.resDataData.userData![0].firstName}');
    return Scaffold(
      drawer:
          ClipRRect(borderRadius: BorderRadius.zero, child: const SideDrawer()),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
        ),
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
        title: Text(
          'Hello, $userFirstName'.capitalize(),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AccountBalanceWidget(),
                verticalSpace(30),
                Text(
                  'Services',
                  style: AppTextStyles.font18.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                verticalSpace(16),
                ServicesSection(
                    userServices: userServices,
                    servicesIcon: servicesIcon,
                    reloadData: reloadData),
                verticalSpace(30),
                //  reloadData.loadData.userData?.map((e) => e.level) == 1
                reloadData.loadData.userData?[0].level == '1'
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
                            onTap: () =>
                                nextScreen(context, const TransactionScreen()),
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
                reloadData.loadData.userData?[0].level == '1'
                    ?  TransactionHistoryContainer()
                    : const OverViewContainer(),
              ],
            ),
          ),
        ),
      ),
    );
    //  });
  }
}
