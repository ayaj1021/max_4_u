import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/auth/login_screen.dart';
import 'package:max_4_u/app/screens/profile/profile_screen.dart';
import 'package:max_4_u/app/screens/settings/settings_screen.dart';
import 'package:max_4_u/app/screens/support/support_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
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
    getUserType();
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

  String? userType;

  getUserType() async {
    final user = await SecureStorage().getUserType();
    setState(() {
      userType = user;
    });
    return user;
  }

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProviderImpl, ReloadUserDataProvider>(
      builder: (context, authProv, reloadData, _) {
        final firstName = EncryptData.decryptAES(
            authProv.resDataData.userData![0].firstName.toString());
        final userId = EncryptData.decryptAES(
            authProv.resDataData.userData![0].uniqueId.toString());
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
                onTap: () => nextScreen(context, ProfileScreen()),
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
                onTap: () => nextScreen(context, SettingsScreen()),
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
                onTap: () => nextScreen(context, SupportScreen()),
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
              Container(
                height: 56.h,
                width: 288.w,
                decoration: BoxDecoration(
                    color: authProv.userLevel == '1'
                        ? AppColors.secondaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  onTap: () {
                    reloadData.loadData.verificationStatus!.status ==
                            'incomplete'
                        ? nextScreen(context, const BecomeVendorScreen())
                        : reloadData.loadData.verificationStatus!.status ==
                                'pending'
                            ? showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: Container(
                                        height: 255.h,
                                        width: 356.w,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 22, horizontal: 18),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: AppColors.whiteColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Color(0xff292D32)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 67.h,
                                              width: 67.w,
                                              child: Image.asset(
                                                  'assets/images/vendor_pending_image.png'),
                                            ),
                                            verticalSpace(10),
                                            Text(
                                              'Pending Review',
                                              style:
                                                  AppTextStyles.font18.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.subTextColor,
                                              ),
                                            ),
                                            verticalSpace(15),
                                            Text(
                                              'Your application is under review, you will be notified once it is approved',
                                              style:
                                                  AppTextStyles.font14.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.textColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ));
                                })
                            : SizedBox.shrink();
                  },
                  leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: authProv.userLevel == '1'
                          ? SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset('assets/icons/user_icon.png'))
                          : authProv.userLevel == '5'
                              ? SizedBox.shrink()
                              : userType == '1'?  Image.asset(
                                   'assets/icons/vendor_white_icon.png'
                  ): SizedBox.shrink()
                  ),
                  title: Text(
                    authProv.userLevel == '1'
                        ? 'Become a vendor'
                        : '',
                    style: AppTextStyles.font16.copyWith(
                      fontWeight: FontWeight.w500,
                      color: authProv.userLevel == '1'
                          ? AppColors.whiteColor
                          : authProv.userLevel == '5'
                              ? Colors.transparent
                              : AppColors.blackColor,
                    ),
                  ),
                ),
              ),
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
