import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/provider/vendor_check_provider.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/vendor_sections/screens/become_vendor_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<VendorCheckProvider>(builder: (context, vendor, _) {
      return Drawer(
        backgroundColor: AppColors.whiteColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          children: [
            Row(
              children: [
                Container(
                  height: 52.h,
                  width: 52.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: const Color(0xff333333),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset('assets/images/user_profile_image.png'),
                  ),
                ),
                horizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adedokun Praise',
                      style: AppTextStyles.font20
                          .copyWith(color: const Color(0xff333333)),
                    ),
                    verticalSpace(2),
                    Text(
                      'User ID -1235364',
                      style: AppTextStyles.font12
                          .copyWith(fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
            verticalSpace(24),
            ListTile(
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/profile_icon.png')),
              title: Text(
                'My Profile',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/setting_icon.png')),
              title: Text(
                'Settings',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/support_icon.png')),
              title: Text(
                'Contact Us',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            verticalSpace(342),
            Consumer<VendorCheckProvider>(builder: (context, vendor, _) {
              return Container(
                height: 56.h,
                width: 288.w,
                decoration: BoxDecoration(
                    color: vendor.isVendor
                        ? AppColors.secondaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  onTap: () {
                    vendor.changeVendor();
                    final userType =
                        Provider.of<VendorCheckProvider>(context, listen: false)
                            .isVendor;
                    SharedPref().saveUserType(userType);
                    Future.delayed(const Duration(seconds: 3), () {
                      nextScreen(context, const BecomeVendorScreen());
                    });
                  },
                  leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: vendor.isVendor
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset('assets/icons/user_icon.png'))
                          : Image.asset(vendor.isVendor
                              ? 'assets/icons/vendor_white_icon.png'
                              : 'assets/icons/vendor_icon.png')),
                  title: Text(
                    vendor.isVendor == true
                        ? 'Become a user'
                        : 'Become a vendor',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: vendor.isVendor == true
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                  ),
                ),
              );
            }),
            ListTile(
              onTap: () => nextScreenReplace(context, const LoginScreen()),
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/logout_icon.png')),
              title: Text(
                'Log out',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      );
    });
  }
}
