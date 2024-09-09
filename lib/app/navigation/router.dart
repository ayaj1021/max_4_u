import 'package:flutter/widgets.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_screen.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/presentation/views/set_up_new_data_prices_screen.dart';
import 'package:max_4_u/app/presentation/general_widgets/splash/splash_screen.dart';

class AppRouter {
  static final Map<String, Widget Function(BuildContext)> _routes = {
    SplashScreen.routeName: (context) => const SplashScreen(),
    // RegisterOne.routeName: (context) => const RegisterOne(),
    // Login.routeName: (context) => const Login(),
    OnboardScreen.routeName: (context) => const OnboardScreen(),
    // // OTPVerification.routeName: (context) => const OTPVerification(),
    // Dashboard.routeName: (context) => const Dashboard(),
    // SupportPage.routeName: (context) => const SupportPage(),
    // MyInformationPage.routeName: (context) => const MyInformationPage(),
    // ChangePasswordView.routeName: (context) => const ChangePasswordView(),
     SetupNewDataPricesScreen.routeName: (context) => const SetupNewDataPricesScreen(),

    // ChangeTransactionPinView.routeName: (context) => const ChangeTransactionPinView(),
  };
  static Map<String, Widget Function(BuildContext)> get routes => _routes;
}
