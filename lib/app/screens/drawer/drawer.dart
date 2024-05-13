import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              style: AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/icons/setting_icon.png')),
            title: Text(
              'Settings',
              style: AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/icons/support_icon.png')),
            title: Text(
              'Contact Us',
              style: AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          verticalSpace(342),
          ListTile(
            leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/icons/vendor_icon.png')),
            title: Text(
              'Become a vendor',
              style: AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            ),
            trailing: SizedBox(
              height: 15,
              
              child: Switch(value: false, onChanged: (newValue){})),
          ),
          ListTile(
            leading: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset('assets/icons/logout_icon.png')),
            title: Text(
              'Log out',
              style: AppTextStyles.font16.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
