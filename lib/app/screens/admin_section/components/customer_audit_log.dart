import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/super_admin/audit_log_provider.dart';
import 'package:max_4_u/app/screens/admin_section/components/log_details_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class CustomerAuditLog extends StatefulWidget {
  const CustomerAuditLog({super.key});

  @override
  State<CustomerAuditLog> createState() => _CustomerAuditLogState();
}

class _CustomerAuditLogState extends State<CustomerAuditLog> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuditLogProvider>(context, listen: false).getAllAuditLog();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuditLogProvider>(
      builder: (context, auditLog, _) {
        return SingleChildScrollView(
          child: auditLog.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
              : auditLog.allAuditResponse.data == null
                  ? Center(
                      child: Text(
                        'No data',
                        style: AppTextStyles.font14.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  : auditLog.allAuditResponse.data!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 92.h,
                                  width: 92.w,
                                  child: Image.asset(
                                      'assets/images/no_beneficiary_image.png')),
                              verticalSpace(24),
                              Text(
                                'You have no transaction yet',
                                style: AppTextStyles.font14.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: List.generate(
                            auditLog.allAuditResponse.data!.length,
                            (index) {
                              // final data =  auditLog.allAuditResponse.data![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/images/profile_avatar.png'),
                                ),
                                title: Text(
                                  ' ${auditLog.firstName} ${auditLog.lastName}',
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff475569),
                                  ),
                                ),
                                subtitle: Text(
                                  '',
                                  style: AppTextStyles.font16.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff333333),
                                  ),
                                ),
                                onTap: () => nextScreen(
                                  context,
                                  LogDetailsScreen(
                                    firstName: auditLog.firstName,
                                    lastName: auditLog.lastName,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
        );
      },
    );
  }
}
