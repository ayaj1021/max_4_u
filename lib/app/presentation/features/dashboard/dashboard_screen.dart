import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/requests_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/users/presentation/view/users_screen.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/view/super_admin_users_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/home_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/profile/profile_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/support/support_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/transaction_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/customers_section/customer_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // String userType = '';

  // getUserType() async {
  //   final userLevel = await SecureStorage().getUserLevel();
  //   print('this is dashboard user level: $userLevel');
  //   setState(() {
  //     userType = userLevel;
  //   });
  //  // return userLevel;
 // }

  @override
  void initState() {
   // getUserType();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final authProvider =
    //       Provider.of<AuthProviderImpl>(context, listen: false);
    //   authProvider.loginUser(email: '', password: '');
    // });

    super.initState();
  }

  final userPages = [
    const HomeScreen(),
    const TransactionScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  final vendorPages = [
    const HomeScreen(),
    const CustomerScreen(),
    const TransactionScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  final adminPages = [
    const HomeScreen(),
    const UsersScreen(),
    const TransactionScreen(),
    const RequestsScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;
  changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBody({required String userLevel, required int selectedIndex}) {
    List<Widget> pages;
    switch (userLevel) {
      case '1':
        pages = [
          const HomeScreen(),
          const TransactionScreen(),
          const SupportScreen(),
          const ProfileScreen(),
        ];
        break;
      case '2':
        pages = [
          const HomeScreen(),
          const CustomerScreen(),
          const TransactionScreen(),
          const SupportScreen(),
          const ProfileScreen(),
        ];
        break;

      case '4':
        pages = [
          const HomeScreen(),
          const SuperAdminUserScreen(),
          const TransactionScreen(),
          const RequestsScreen(),
          const ProfileScreen(),
        ];
        break;
      case '5':
        pages = [
          const HomeScreen(),
          const SuperAdminUserScreen(),
          const TransactionScreen(),
          const RequestsScreen(),
          const ProfileScreen(),
        ];
        break;
      default:
        pages = [
          Center(child: Text('Error Page')),
        ];
        break;
    }
    return pages[selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProviderImpl, ReloadUserDataProvider>(
      builder: (context, authProv, reloadData, _) {
        return Scaffold(
          body: _getBody(
           // userLevel: userType,
             userLevel: authProv.userLevel,
            selectedIndex: _selectedIndex,
          ),
          //pages[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            currentIndex: _selectedIndex,
            onTap: changePage,
            items: _getBottomNavBarItems(authProv.userLevel),
            //items: _getBottomNavBarItems(userType),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _getBottomNavBarItems(String appUserLevel) {
    switch (appUserLevel) {
      case '1':
        return [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined), label: 'Support'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ];

      case '2':
        // pages = vendorPages;
        return [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Customers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined), label: 'Support'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ];
      case '4':
        return [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined), label: 'Requests'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ];
      case '5':
        return [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent_outlined), label: 'Requests'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ];

      default:
        return [
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
        ];
    }
  }
}
