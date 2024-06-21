import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
import 'package:max_4_u/app/provider/admin_section/approve_vendor_request_provider.dart';
import 'package:max_4_u/app/provider/admin_section/deny_vendor_request_provider.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_vendors_requests_provider.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/faq_provider.dart';
import 'package:max_4_u/app/provider/super_admin/audit_log_provider.dart';
import 'package:max_4_u/app/provider/super_admin/deactivate_user_provider.dart';
import 'package:max_4_u/app/provider/super_admin/make_admin_provider.dart';
import 'package:max_4_u/app/provider/super_admin/remove_admin_provider.dart';
import 'package:max_4_u/app/provider/vendor/become_a_vendor_provider.dart';
import 'package:max_4_u/app/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/provider/buy_data_provider.dart';
import 'package:max_4_u/app/provider/change_email_provider.dart';
import 'package:max_4_u/app/provider/change_password_provider.dart';
import 'package:max_4_u/app/provider/choose_option_provider.dart';
import 'package:max_4_u/app/provider/delete_account_provider.dart';
import 'package:max_4_u/app/provider/fund_account_provider.dart';
import 'package:max_4_u/app/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/provider/get_notification_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/provider/vendor/generate_account_number_provider.dart';
import 'package:max_4_u/app/provider/vendor/remove_customer_provider.dart';
import 'package:max_4_u/app/provider/save_beneficiary_provider.dart';
import 'package:max_4_u/app/provider/super_admin/setup_prices_provider.dart';
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
              ChangeNotifierProvider(create: (_) => FundAccountProvider()),
              ChangeNotifierProvider(create: (_) => DeactivateUserProvider()),
              ChangeNotifierProvider(create: (_) => MakeAdminProvider()),
              ChangeNotifierProvider(create: (_) => AuditLogProvider()),
              ChangeNotifierProvider(
                  create: (_) => GetAllVendorRequestsProvider()),
              ChangeNotifierProvider(
                  create: (_) => ApproveVendorRequestProvider()),
              ChangeNotifierProvider(
                  create: (_) => DenyVendorRequestProvider()),
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
                scaffoldBackgroundColor: AppColors.scaffoldBgColor2,
              ),
              home: const SplashScreen(),
            ),
          );
        });
  }
}
