import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/provider/vendor_check_provider.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/selecting_user_type.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/screens/vendor_sections/screens/become_vendor_screen.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String firstName = '';
  String lastName = '';
  String userId = '';

  @override
  void initState() {
    getNames();
    super.initState();
  }

  getNames() async {
    final name = await SecureStorage().getFirstName();
    final surname = await SecureStorage().getLastName();
    final id = await SecureStorage().getUniqueId();

    setState(() {
      firstName = name;
      lastName = surname;
      userId = id;
    });
  }

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    //  final vendor = Provider.of<VendorCheckProvider>(context);
    // final userType = UserType.selectUserType(vendor.isVendor);
    return Consumer<VendorCheckProvider>(
      builder: (context, vendor, _) {
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
                      child: Image.asset('assets/images/profile_avatar.png'),
                    ),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$firstName $lastName',
                        style: AppTextStyles.font20
                            .copyWith(color: const Color(0xff333333)),
                      ),
                      verticalSpace(2),
                      Text(
                        'User ID - $userId',
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
                  style: AppTextStyles.font16
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/icons/setting_icon.png')),
                title: Text(
                  'Settings',
                  style: AppTextStyles.font16
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              ListTile(
                leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/icons/support_icon.png')),
                title: Text(
                  'Contact Us',
                  style: AppTextStyles.font16
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
              verticalSpace(342),
              Consumer<VendorCheckProvider>(builder: (context, vendor, _) {
                return Container(
                  height: 56.h,
                  width: 288.w,
                  decoration: BoxDecoration(
                      color: vendor.isVendor == '1'
                          ? AppColors.secondaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    onTap: () {
                      vendor.changeVendor('2');
                      // final userType =
                      //     Provider.of<VendorCheckProvider>(context, listen: false)
                      //         .isVendor;
                      // SecureStorage().saveUserType(userType);
                      Future.delayed(const Duration(seconds: 1), () {
                        nextScreen(context, const BecomeVendorScreen());
                      });
                    },
                    leading: SizedBox(
                        height: 24,
                        width: 24,
                        child: vendor.isVendor == '1'
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    Image.asset('assets/icons/user_icon.png'))
                            : Image.asset(vendor.isVendor == '1'
                                ? 'assets/icons/vendor_white_icon.png'
                                : 'assets/icons/vendor_icon.png')),
                    // subtitle: ElevatedButton(
                    //   onPressed: () {
                    //     log(userType);
                    //    // log('${vendor.isVendor}');
                    //   },
                    //   child: Text('press'),
                    // ),
                    title: Text(
                      userLevel,
                      // vendor.isVendor == '1'
                      //     ? 'Become a user'
                      //     : 'Become a vendor',
                      style: AppTextStyles.font16.copyWith(
                        fontWeight: FontWeight.w500,
                        color: vendor.isVendor == '1'
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                );
              }),
              ListTile(
                onTap: () async {
                  await SecureStorage().logoutUser();
                  showMessage(context, 'Log out successful');
                  nextScreenReplace(context, LoginScreen());
                },
                leading: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/icons/logout_icon.png')),
                title: Text(
                  'Log out',
                  style: AppTextStyles.font16
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
