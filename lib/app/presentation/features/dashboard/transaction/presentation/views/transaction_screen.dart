import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/month_dropdown_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/widgets/transaction_list_section.dart';

import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/auto_renewal_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _searchController = TextEditingController();

  TransactionHistory? retrievedTransactionHistory;

  bool isSearching = false;
  @override
  void initState() {
    getTransactions();
    _searchController.addListener(_filterTransactions);

    super.initState();
  }

  List<Transaction>? filteredTransactions = [];

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredTransactions =
          retrievedTransactionHistory?.data?.where((transaction) {
        return (transaction.number?.toLowerCase().contains(query) ?? false) ||
            (transaction.type?.toLowerCase().contains(query) ?? false) ||
            (transaction.subType?.toLowerCase().contains(query) ?? false) ||
            (transaction.purchaseType?.toLowerCase().contains(query) ??
                false) ||
            (transaction.productAmount?.toLowerCase().contains(query) ??
                false) ||
            (transaction.amountPaid?.toLowerCase().contains(query) ?? false);
      }).toList();
    });
  }

  getTransactions() async {
    final storage = await SecureStorage();

    retrievedTransactionHistory = (await storage.getUserTransactions());
    setState(() {
      filteredTransactions = retrievedTransactionHistory?.data;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final categories = [
    'All',
    'Added funds',
    'Data',
    'Airtime',
  ];

  final status = [
    'All',
    'Successful',
    'Pending',
    'Failed',
  ];

  int? categoryIndex;
  int? statusIndex;

  String? dateString;

  void shareContent(String content) {
    Share.share(content);
  }

  final List icons = [
    'assets/icons/call_icon.png',
    'assets/icons/data_icon.png',
    'assets/icons/fund_wallet_icon.png',
  ];

  final List colors = [
    Color(0xffDEEDF7),
    Color(0xffD6DDFE),
    Color(0xffE8D6FE),
  ];
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('MMMM d, yyyy h:mm a');
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        final dataList = reloadData.loadData.transactionHistory!.data!;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor2,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Transactions',
                          style: AppTextStyles.font18,
                        ),
                        horizontalSpace(90),
                        PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'Page1') {
                              nextScreen(context, AutoRenewalScreen());
                            }
                          },
                          elevation: 0,
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'Page1',
                                child: Text(
                                  'Auto renewal',
                                  style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.mainTextColor),
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),

                    // ignore: unnecessary_null_comparison
                    dataList == null
                        ? Center(
                            child: Text(
                              'No data',
                              style: AppTextStyles.font14.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        : dataList.isEmpty
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
                            : TransactionListSection(
                                searchController: _searchController,
                                filteredTransactions: filteredTransactions,
                                dateFormat: dateFormat,
                                icons: icons,
                                colors: colors),
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

String _monthToString(Months month) {
  switch (month) {
    case Months.January:
      return 'January';
    case Months.February:
      return 'February';
    case Months.March:
      return 'March';
    case Months.April:
      return 'April';
    case Months.May:
      return 'May';
    case Months.June:
      return 'June';
    case Months.July:
      return 'July';
    case Months.August:
      return 'August';
    case Months.September:
      return 'September';
    case Months.October:
      return 'October';
    case Months.November:
      return 'November';
    case Months.December:
      return 'December';

    default:
      return '';
  }
}
