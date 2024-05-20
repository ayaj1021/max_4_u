import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/choose_option_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
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
