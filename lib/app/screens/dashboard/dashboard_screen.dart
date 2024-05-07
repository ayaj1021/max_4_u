import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/home/home_screen.dart';
import 'package:max_4_u/app/screens/profile/profile_screen.dart';
import 'package:max_4_u/app/screens/support/support_screen.dart';
import 'package:max_4_u/app/screens/transaction/transaction_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final pages = [
    const HomeScreen(),
    const TransactionScreen(),
    const ProfileScreen(),
    const SupportScreen(),
  ];
  int _selectedIndex = 0;
  changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
          currentIndex: _selectedIndex,
          onTap: changePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined), label: 'Transaction'),
                BottomNavigationBarItem(
                icon: Icon(Icons.support_agent_outlined), label: 'Support'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ]),
    );
  }
}
