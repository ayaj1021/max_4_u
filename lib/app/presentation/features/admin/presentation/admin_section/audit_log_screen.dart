import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/customer_audit_log.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/vendor_audit_log.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/audit_log_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/search_input_widget.dart';
import 'package:provider/provider.dart';

class AuditLogScreen extends StatefulWidget {
  const AuditLogScreen({super.key});

  @override
  State<AuditLogScreen> createState() => _AuditLogScreenState();
}

class _AuditLogScreenState extends State<AuditLogScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuditLogProvider>(
      builder: (context, auditLog, _) {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Audit log',
                      style: AppTextStyles.font18.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  verticalSpace(24),
                  SearchInputWidget(
                    controller: _searchController,
                    hintText: 'Search for a customer',
                    prefixIcon: Icon(Icons.search),
                  ),
                  verticalSpace(32),
                  Container(
                    height: 639.h,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffE8E8E8),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 38.h,
                          width: 333.w,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Color(0xffDADBDD),
                              borderRadius: BorderRadius.circular(8)),
                          child: TabBar(
                            indicator: BoxDecoration(
                                color: const Color(0xffB0D3EB),
                                borderRadius: BorderRadius.circular(6)),
                            controller: _tabController,
                            indicatorColor: Colors.transparent,
                            labelColor: AppColors.blackColor,
                            tabs: [
                              Container(
                                height: 31.h,
                                width: 152.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Text('Customers'),
                              ),
                              Container(
                                height: 31.h,
                                width: 152.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6)),
                                child: const Text('Vendors'),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(23),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              CustomerAuditLog(),
                              VendorAuditLog(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        );
      }
    );
  }
}
