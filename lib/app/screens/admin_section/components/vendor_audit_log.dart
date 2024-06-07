import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class VendorAuditLog extends StatelessWidget {
  const VendorAuditLog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 560.h,
        child: ListView.builder(itemBuilder: (_, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile_avatar.png'),
            ),
            title: Text(
              'Peace Adedokun',
              style: AppTextStyles.font14.copyWith(
                fontWeight: FontWeight.w400,
                color: Color(0xff475569),
              ),
            ),
            subtitle: Text(
              '93395853348',
              style: AppTextStyles.font16.copyWith(
                fontWeight: FontWeight.w500,
                color: Color(0xff333333),
              ),
            ),
          );
        }));
  }
}
