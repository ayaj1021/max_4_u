import 'package:flutter/material.dart';
import 'package:max_4_u/app/provider/vendor_check_provider.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/customer_screen.dart';
import 'package:max_4_u/app/screens/home/home_screen.dart';
import 'package:max_4_u/app/screens/profile/profile_screen.dart';
import 'package:max_4_u/app/screens/support/support_screen.dart';
import 'package:max_4_u/app/screens/transaction/transaction_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/vendor_sections/screens/vendor_transaction_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final userPages = [
    const HomeScreen(),
    const TransactionScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];

  final vendorPages = [
    const HomeScreen(),
    const CustomerScreen(),
    const VendorTransactionScreen(),
    const SupportScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;
  changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorCheckProvider>(builder: (context, vendor, _) {
      return Scaffold(
        body: vendor.isVendor
            ? vendorPages[_selectedIndex]
            : userPages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            currentIndex: _selectedIndex,
            onTap: changePage,
            items: vendor.isVendor
                ? const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.people_outline), label: 'Customers'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.receipt_long_outlined),
                        label: 'Transaction'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.support_agent_outlined),
                        label: 'Support'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Profile'),
                  ]
                : const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.receipt_long_outlined),
                        label: 'Transaction'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.support_agent_outlined),
                        label: 'Support'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Profile'),
                  ]),
      );
    });
  }
}
