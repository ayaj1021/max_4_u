import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/month_dropdown_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/transaction_detail_screen.dart';

import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/auto_renewal_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
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

  Future<dynamic> filterTransactionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              height: 600.h,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppColors.whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/icons/cancel_icon.png'),
                    ),
                  ),
                  verticalSpace(9),
                  //Choose category filter section
                  Text(
                    'CATEGORIES',
                    style: AppTextStyles.font12
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  verticalSpace(12),
                  SizedBox(
                    height: 120.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categories[index],
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainTextColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categoryIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: categoryIndex == index
                                              ? AppColors.primaryColor
                                              : const Color(0xff333333),
                                        ),
                                      ),
                                      child: categoryIndex == index
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: categoryIndex == index
                                                    ? AppColors.primaryColor
                                                    : AppColors.whiteColor,
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff333333),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                            ],
                          );
                        }),
                  ),
                  verticalSpace(10),
                  Image.asset('assets/icons/divider_image.png'),
                  //Choose status user section
                  verticalSpace(10),
                  Text(
                    'STATUS',
                    style: AppTextStyles.font12
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  verticalSpace(12),
                  SizedBox(
                    height: 120.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: status.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    status[index],
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainTextColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        statusIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: statusIndex == index
                                              ? AppColors.primaryColor
                                              : const Color(0xff333333),
                                        ),
                                      ),
                                      child: statusIndex == index
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: statusIndex == index
                                                    ? AppColors.primaryColor
                                                    : AppColors.whiteColor,
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff333333),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                            ],
                          );
                        }),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 48.h,
                          width: 169.w,
                          child: ButtonWidget(
                            text: 'Reset',
                            color: AppColors.whiteColor,
                            textColor: AppColors.primaryColor,
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                          )),
                      SizedBox(
                          height: 48.h,
                          width: 169.w,
                          child: const ButtonWidget(
                            text: 'Apply filter',
                          ))
                    ],
                  )
                ],
              ),
            );
          });
        });
  }
}

class TransactionListSection extends StatelessWidget {
  const TransactionListSection({
    super.key,
    required TextEditingController searchController,
    required this.filteredTransactions,
    required this.dateFormat,
    required this.icons,
    required this.colors,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final List<Transaction>? filteredTransactions;
  final DateFormat dateFormat;
  final List icons;
  final List colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputField(
          controller: _searchController,
          hintText: 'Search in transactions',
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xff4F4F4F),
          ),
        ),
        verticalSpace(18),
        // Row(
        //   mainAxisAlignment:
        //       MainAxisAlignment.spaceBetween,
        //   children: [
        //     DropdownButton<Months>(
        //       underline: const SizedBox(),
        //       value: _selectedMonth,
        //       items:
        //           Months.values.map((Months month) {
        //         return DropdownMenuItem(
        //             value: month,
        //             child: Container(
        //                 padding: EdgeInsets.zero,
        //                 child: Text(
        //                     _monthToString(month))));
        //       }).toList(),
        //       onChanged: (newValue) {
        //         setState(() {
        //           _selectedMonth = newValue!;
        //         });
        //       },
        //     ),
        //     GestureDetector(
        //       onTap: () {
        //         filterTransactionBottomSheet(context);
        //       },
        //       child: Row(
        //         children: [
        //           Text(
        //             'Filter',
        //             style: AppTextStyles.font16,
        //           ),
        //           Icon(Icons.filter_alt_outlined)
        //         ],
        //       ),
        //     )
        //   ],
        // ),

        Column(
          children: List.generate(
            // data.length,
            filteredTransactions!.length,
            (index) {
              final data = filteredTransactions!;

              return InkWell(
                onTap: () => nextScreen(
                    context,
                    TransactionDetailsScreen(
                      amount: '${data[index].amountPaid}',
                      referenceId: '${data[index].referenceId}',
                      status: '${data[index].status}',
                      date:
                          '${dateFormat.format(data[index].regDate as DateTime)}',
                      type: '${data[index].type}',
                      number: '${data[index].number}',
                      subType: '${data[index].subType}',
                    )),
                child: Column(
                  children: [
                    TransactionSection(
                      transactionIcon: data[index].subType!.contains('card')
                          ? icons[2]
                          : data[index].subType!.contains('data')
                              ? icons[1]
                              : icons[0],
                      transactionType: '${data[index].subType}'.capitalize(),
                      transactionDate:
                          '${dateFormat.format(data[index].regDate as DateTime)}',
                      transactionAmount: 'N${data[index].amountPaid}',
                      transactionStatus: '${data[index].status}',
                      transactionColor: data[index].subType!.contains('card')
                          ? colors[1]
                          : data[index].subType!.contains('data')
                              ? colors[2]
                              : colors[0],
                      // Color(0xffD6DDFE),
                      transactionStatusColor: data[index].status == 'success'
                          ? Colors.green
                          : data[index].status == 'pending'
                              ? Color(0xffA6B309)
                              : Colors.red,
                      transactionNumber:
                          '${data[index].number ?? '${data[index].referenceId!.substring(data[index].referenceId!.length - 5)}'}',
                    ),
                    verticalSpace(8),
                    Divider(
                      color: AppColors.blackColor.withOpacity(0.1),
                    ),
                    verticalSpace(8),
                  ],
                ),
              );
            },
          ),
        )
      ],
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
