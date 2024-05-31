import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/provider/buy_data_provider.dart';
import 'package:max_4_u/app/provider/change_email_provider.dart';
import 'package:max_4_u/app/provider/change_password_provider.dart';
import 'package:max_4_u/app/provider/choose_option_provider.dart';
import 'package:max_4_u/app/provider/delete_account_provider.dart';
import 'package:max_4_u/app/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/provider/get_notification_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/provider/remove_customer_provider.dart';
import 'package:max_4_u/app/provider/save_beneficiary_provider.dart';
import 'package:max_4_u/app/provider/vendor_check_provider.dart';
import 'package:max_4_u/app/screens/splash/splash_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, _) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProviderImpl()),
              ChangeNotifierProvider(create: (_) => RemoveCustomerProvider()),
              ChangeNotifierProvider(create: (_) => ActivateAutoRenewalProvider()),
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
              ChangeNotifierProvider(create: (_) => VendorCheckProvider()),
              ChangeNotifierProvider(create: (_) => ChooseOptionsProvider()),
              ChangeNotifierProvider(create: (_) => ObscureTextProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.scaffoldBgColor2,
              ),
              home: const SplashScreen(),
            ),
          );
        });
  }
}
