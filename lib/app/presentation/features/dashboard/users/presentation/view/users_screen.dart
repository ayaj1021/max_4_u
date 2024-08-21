import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_users_screen/presentation/view/admin_users_screen.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/view/super_admin_users_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? userType;

  @override
  void initState() {
    super.initState();
    getUserType();
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
    return Scaffold(
      body: SafeArea(
        child: userType == '5' ? SuperAdminUserScreen() : AdminUserScreen(),
      ),
    );
  }
}
