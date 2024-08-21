import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/model/admin/get_all_app_users_model.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/widgets/consumer_vendor_admin_stats_section.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/widgets/user_stats_section.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class SuperAdminUserScreen extends StatefulWidget {
  const SuperAdminUserScreen({super.key});

  @override
  State<SuperAdminUserScreen> createState() => _SuperAdminUserScreenState();
}

class _SuperAdminUserScreenState extends State<SuperAdminUserScreen>
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
    _tabController = TabController(length: 3, vsync: this);
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
                    // getAllAppUsers.isLoading
                    //     ? ShimmerWidget.rectangular(
                    //         height: 85.h,
                    //         width: MediaQuery.of(context).size.width,
                    //       )
                    //     :

                    UserStatsSection(
                      getAllAppUsers: getAllAppUsers,
                    ),
                    verticalSpace(20),
                    usersList.isEmpty
                        ? ConsumerVendorAdminStatsSection(
                            tabController: _tabController)
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
