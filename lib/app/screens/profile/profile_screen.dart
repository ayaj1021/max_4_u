import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/screens/profile/edit_profile_screen.dart';
import 'package:max_4_u/app/screens/settings/settings_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Center(
              child: Text(
                'Profile',
                style: AppTextStyles.font18.copyWith(
                  color: AppColors.mainTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            verticalSpace(33),
            Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: const Color(0xff333333),
                ),
              ),
              child: ClipOval(
                child: Image.asset('assets/images/profile_avatar.png'),
              ),
            ),
            verticalSpace(12),
            Text(
              '$firstName $lastName',
              style:
                  AppTextStyles.font20.copyWith(color: const Color(0xff333333)),
            ),
            verticalSpace(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User ID -$userId',
                  style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff787878)),
                ),
                horizontalSpace(3),
                const Icon(
                  Icons.copy,
                  size: 14,
                  color: AppColors.primaryColor,
                )
              ],
            ),
            verticalSpace(32),
            ListTile(
              onTap: () => nextScreen(
                context,
                const EditProfileScreen(),
              ),
              leading: SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/icons/profile_icon.png')),
              title: Text(
                'Edit profile',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              onTap: () => nextScreen(context, const SettingsScreen()),
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
              onTap: () {
                removeVendorBottomSheet(context);
              },
              leading: SizedBox(
                  height: 23,
                  width: 31,
                  child: Image.asset('assets/icons/vendor_icon.png')),
              title: Text(
                'Vendor',
                style:
                    AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            // ListTile(
            //   leading: SizedBox(
            //       height: 24,
            //       width: 24,
            //       child: Image.asset('assets/icons/support_icon.png')),
            //   title: Text(
            //     'Contact support',
            //     style:
            //         AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }

  Future<dynamic> removeVendorBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 321.h,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 18),
            decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/icons/cancel_icon.png'),
                    ),
                  ),
                ),
                Text(
                  'Vendor',
                  style: AppTextStyles.font14
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                verticalSpace(20),
                CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child:
                          Image.asset('assets/images/user_profile_image.png'),
                    )),
                verticalSpace(10),
                Text(
                  'Julian Mike',
                  style: AppTextStyles.font14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainTextColor,
                  ),
                ),
                verticalSpace(4),
                Text(
                  '09169784011',
                  style: AppTextStyles.font14
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                verticalSpace(20),
                ButtonWidget(
                  text: 'Remove Vendor',
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Container(
                              height: 290.h,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 23),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.whiteColor,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/icons/cancel_icon.png'),
                                      ),
                                    ),
                                  ),
                                  verticalSpace(19),
                                  Text(
                                    'Remove Vendor',
                                    style: AppTextStyles.font20.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  verticalSpace(12),
                                  Text(
                                    'You will not be registered under this vendor anymore. Are you sure you want to remove the vendor?',
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  ),
                                  verticalSpace(37),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          height: 48.h,
                                          width: 126.w,
                                          child: ButtonWidget(
                                            text: 'Cancel',
                                            color: const Color(0xffEEEFEF),
                                            onTap: () {},
                                            textColor: AppColors.primaryColor,
                                          )),
                                      SizedBox(
                                          height: 48.h,
                                          width: 126.w,
                                          child: ButtonWidget(
                                            text: 'Confirm',
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
          );
        });
  }
}
