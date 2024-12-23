import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/model/admin/get_all_app_users_model.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/admin_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/consumer_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/vendor_component.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/widgets/user_stats_section.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AdminUserScreen extends StatefulWidget {
  const AdminUserScreen({super.key});

  @override
  State<AdminUserScreen> createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String? userType;

  List<UserData> usersList = [];

  List<UserData> users = [];

  @override
  void initState() {
    getUserType();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllAppUsers>(context, listen: false).getAllUsers();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllAppUsers>(context, listen: false).getAllAdmins();
    });

    usersList = users;

    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void runFilter(String enteredKeyword) {
    List<UserData> results = [];
    if (enteredKeyword.isEmpty) {
      results = users;
    } else {
      results = users
          .where((user) => user.firstName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      usersList = results;
    });
  }

  getUserType() async {
    final user = await SecureStorage().getUserType();
    setState(() {
      userType = user;
    });
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllAppUsers, ReloadUserDataProvider>(
      builder: (context, getAllAppUsers, reloadData, _) {
        // final users = getAllAppUsers.getAllUsers();

        // final level = reloadData.loadData.userData![0].level;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Users',
                          style: AppTextStyles.font18,
                        ),
                        // horizontalSpace(140),
                        // SizedBox(
                        //     height: 24,
                        //     child: Image.asset('assets/icons/export_icon.png'))
                      ],
                    ),
                    verticalSpace(24),
                    getAllAppUsers.isLoading
                        ? ShimmerWidget.rectangular(
                            height: 85.h,
                            width: MediaQuery.of(context).size.width,
                          )
                        : UserStatsSection(
                            getAllAppUsers: getAllAppUsers,
                          ),
                    verticalSpace(20),
                    usersList.isEmpty
                        ? Container(
                            //height: 562.h,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              color: Color(0xffE8E8E8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  // height: 38.h,
                                  width: 350.w,
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Color(0xffDADBDD),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TabBar(
                                    dividerHeight: 0,
                                    indicator: BoxDecoration(
                                        color: const Color(0xffB0D3EB),
                                        borderRadius: BorderRadius.circular(6)),
                                    controller: _tabController,
                                    indicatorColor: Colors.transparent,
                                    labelColor: AppColors.blackColor,
                                    tabs: [
                                      Container(
                                        // height: 31.h,
                                        // width: 192.w,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Consumers',
                                              style: AppTextStyles.font12,
                                            ),
                                            horizontalSpace(4),
                                            Container(
                                              //  height: 12.h,
                                              // width: 12.w,
                                              padding: EdgeInsets.all(3),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  color:
                                                      AppColors.subTextColor),
                                              child: Text(
                                                getAllAppUsers
                                                            .allAppUsers
                                                            .data
                                                            ?.responseData
                                                            ?.totalConsumer ==
                                                        null
                                                    ? ''
                                                    : '${getAllAppUsers.allAppUsers.data?.responseData?.totalConsumer}',
                                                style: AppTextStyles.font12
                                                    .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .whiteColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // height: 31.h,
                                        // width: 162.w,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Vendors',
                                              style: AppTextStyles.font12,
                                            ),
                                            horizontalSpace(7),
                                            Container(
                                              // height: 12.h,
                                              width: 17.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(17),
                                                  color:
                                                      AppColors.subTextColor),
                                              child: Text(
                                                getAllAppUsers
                                                            .allAppUsers
                                                            .data
                                                            ?.responseData
                                                            ?.totalVendor ==
                                                        null
                                                    ? ''
                                                    : '${getAllAppUsers.allAppUsers.data?.responseData?.totalVendor}',
                                                style: AppTextStyles.font12
                                                    .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .whiteColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpace(23),
                                Expanded(
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      CustomersComponent(),
                                      VendorsComponent(),
                                      userType == '5'
                                          ? AdminsComponent()
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text('${usersList[0]}')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xffE6E6E6)),
      ),
    );
  }
}
