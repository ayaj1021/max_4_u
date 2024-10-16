import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/login_screen.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/auto_renewal_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/profile/profile_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/support/support_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/become_vendor_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/settings/presentation/settings_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';
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
      userId = id ?? '';
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
        return ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Drawer(
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
                          '$firstName $lastName'.capitalize(),
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
                  onTap: () => nextScreen(context, AutoRenewalScreen()),
                  leading: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/icons/auto_renew_icon.png')),
                  title: Text(
                    'Auto Renewals',
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
                verticalSpace(270),
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
                                                style: AppTextStyles.font18
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.subTextColor,
                                                ),
                                              ),
                                              verticalSpace(15),
                                              Text(
                                                'Your application is under review, you will be notified once it is approved',
                                                style: AppTextStyles.font14
                                                    .copyWith(
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
                                child: Image.asset(
                                    'assets/icons/vendor_white_icon.png'))
                            : authProv.userLevel == '5'
                                ? SizedBox.shrink()
                                : userType == '1'
                                    ? Image.asset(
                                        'assets/icons/vendor_white_icon.png')
                                    : SizedBox.shrink()),
                    title: Text(
                      authProv.userLevel == '1' ? 'Become a vendor' : '',
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
                    // await SecureStorage().logoutUser();
                    // showMessage(context, 'Log out successful');
                    // nextScreenReplace(context, LoginScreen());
                    logoutAlertDialog(context);
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
          ),
        );
      },
    );
  }

  Future<dynamic> logoutAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                height: 170.h,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                width: MediaQuery.of(context).size.width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Text(
                      'Are you sure you want log out?',
                      style: AppTextStyles.font16.copyWith(
                        color: const Color(0xff4F4F4F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 117.w,
                            height: 44.h,
                            child: ButtonWidget(
                              color: Color(0xff219653),
                              textColor: AppColors.whiteColor,
                              text: 'Yes, Proceed',
                              onTap: () async {
                                await SecureStorage().logoutUser();
                                showMessage(context, 'Log out successful');
                                nextScreenReplace(context, LoginScreen());
                              },
                            )),
                        SizedBox(
                            width: 117.w,
                            height: 44.h,
                            child: ButtonWidget(
                                onTap: () => Navigator.pop(context),
                                color: Color(0xffF2C94C),
                                text: 'No, Cancel')),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

}
