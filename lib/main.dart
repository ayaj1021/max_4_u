import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/navigation/router.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/generate_account_number_provider.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/add_customer_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/approve_vendor_request_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/deny_vendor_request_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_app_users_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_vendors_requests_provider.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/presentation/features/buy_data/provider/buy_data_provider.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/provider/cancel_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/change_email_provider.dart';
import 'package:max_4_u/app/provider/change_password_provider.dart';
import 'package:max_4_u/app/provider/choose_option_provider.dart';
import 'package:max_4_u/app/presentation/features/settings/provider/delete_account_provider.dart';
import 'package:max_4_u/app/provider/faq_provider.dart';
import 'package:max_4_u/app/provider/fund_account_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/presentation/features/notification/provider/get_notification_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/provider/save_beneficiary_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/audit_log_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/deactivate_user_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/make_admin_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/remove_admin_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/setup_prices_provider.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/remove_customer_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Future<bool> checkConnection() async {
//   try {
//     final result = await InternetAddress.lookup('api.max4u.com.ng');
//     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//   } on SocketException catch (_) {
//     return false;
//   }
// }

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseApi().initNotification();
  // NotificationService.initNotification();

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);

  // final connectionChecker = InternetConnectionChecker();

  // final subscription = connectionChecker.onStatusChange.listen(
  //   (InternetConnectionStatus status) {
  //     if (status == InternetConnectionStatus.connected) {
  //       print('Connected to the internet');
  //     } else {
  //       print('Disconnected from the internet');
  //     }
  //   },
  // );

  // Remember to cancel the subscription when it's no longer needed
  //subscription.cancel();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceName = '';
  String deviceModel = '';
  String os = '';
  String location = '';
  String ipAddress = '';
  // late StreamSubscription internetSubscription;
  // bool hasInternet = false;
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // AndroidDeviceInfo? androidDeviceInfo;
  // Future<AndroidDeviceInfo> getInfo() async {
  //   return await deviceInfo.androidInfo;
  // }

  @override
  void initState() {
    super.initState();
    // _getDeviceInfo();
    // _getLocation();
    // _getIPAddress();
    // internetSubscription = InternetConnectionChecker().onStatusChange.listen((status){});
    // final hasInternet = status  == InternetConnectionStatus.connected;

    // setState(() => this.hasInternet = hasInternet

    // );

    debugPrint(ipAddress);
    debugPrint(deviceModel);
    debugPrint(os);
    debugPrint(location);
    debugPrint(ipAddress);
  }

  // Future<void> _getDeviceInfo() async {
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  // if (Platform.isAndroid) {
  //   final androidInfo = await deviceInfoPlugin.androidInfo;
  //   setState(() {
  //     deviceName = androidInfo.device;
  //     deviceModel = androidInfo.model;
  //     os = 'Android ${androidInfo.version.release}';
  //   });
  // } else if (Platform.isIOS) {
  //   final iosInfo = await deviceInfoPlugin.iosInfo;
  //   setState(() {
  //     deviceName = iosInfo.name;
  //     deviceModel = iosInfo.model;
  //     os = 'iOS ${iosInfo.systemVersion}';
  //   });
  // }
//  }

//  Future<void> _getIPAddress() async {
  // final dio = Dio();
  // final response = await dio.get('https://api.ipify.org?format=json');
  // if (response.statusCode == 200) {
  //   final Map<String, dynamic> data = (response.data);
  //   setState(() {
  //     ipAddress = data['ip'];
  //   });
  // }
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor:
            AppColors.primaryColor, // Set your desired status bar color here
        statusBarIconBrightness: Brightness.dark, // Set light or dark icons
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProviderImpl()),
            ChangeNotifierProvider(create: (_) => AutoRenewalCheck()),
            ChangeNotifierProvider(create: (_) => FaqProvider()),
            ChangeNotifierProvider(create: (_) => SetupPricesProvider()),
            ChangeNotifierProvider(create: (_) => GenerateAccountProvider()),
            ChangeNotifierProvider(create: (_) => RemoveAdminProvider()),
            ChangeNotifierProvider(create: (_) => CancelAutoRenewalProvider()),
            ChangeNotifierProvider(create: (_) => FundAccountProvider()),
            ChangeNotifierProvider(create: (_) => DeactivateUserProvider()),
            ChangeNotifierProvider(create: (_) => MakeAdminProvider()),
            ChangeNotifierProvider(create: (_) => AuditLogProvider()),
            ChangeNotifierProvider(
                create: (_) => GetAllVendorRequestsProvider()),
            ChangeNotifierProvider(
                create: (_) => ApproveVendorRequestProvider()),
            ChangeNotifierProvider(create: (_) => DenyVendorRequestProvider()),
            ChangeNotifierProvider(create: (_) => GetAllAppUsers()),
            ChangeNotifierProvider(create: (_) => RemoveCustomerProvider()),
            ChangeNotifierProvider(
                create: (_) => ActivateAutoRenewalProvider()),
            ChangeNotifierProvider(create: (_) => GetAllCustomersProvider()),
            ChangeNotifierProvider(create: (_) => GetNotificationProvider()),
            ChangeNotifierProvider(create: (_) => AddCustomerProvider()),
            ChangeNotifierProvider(create: (_) => BecomeAVendorProvider()),
            ChangeNotifierProvider(create: (_) => SaveBeneficiaryProvider()),
            ChangeNotifierProvider(create: (_) => ReloadUserDataProvider()),
            ChangeNotifierProvider(create: (_) => BuyAirtimeProvider()),
            ChangeNotifierProvider(create: (_) => BuyDataProvider()),
            ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
            ChangeNotifierProvider(create: (_) => DeleteAccountProvider()),
            ChangeNotifierProvider(create: (_) => ChangeEmailProvider()),
            ChangeNotifierProvider(create: (_) => ChooseOptionsProvider()),
            ChangeNotifierProvider(create: (_) => ObscureTextProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              scaffoldBackgroundColor: AppColors.scaffoldBgColor2,
            ),
            routes: AppRouter.routes,
            initialRoute: '/',
            // home: TestData(),
          ),
        );
      },
    );
  }
}
