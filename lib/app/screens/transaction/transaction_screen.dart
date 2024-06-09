import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/month_dropdown_enum.dart';

import 'package:max_4_u/app/model/user_response_model.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/customers_section/auto_renewal_screen.dart';
import 'package:max_4_u/app/screens/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/screens/transaction/transaction_detail_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    getAllTransactions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  Months _selectedMonth = Months.January;

  List allTransactions = [];

  getAllTransactions() async {
    final transactions = await SecureStorage().getUserTransactionHistory();
    setState(() {
      allTransactions = transactions;
      log('${transactions}');
    });
    return transactions;
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

  bool isTapped = false;

  ResponseDataData respData = ResponseDataData();

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBgColor2,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Transactions',
                              style: AppTextStyles.font18,
                            ),
                            horizontalSpace(120),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isTapped = !isTapped;
                                });
                              },
                              child: Icon(Icons.more_vert),
                            )
                          ],
                        ),

                        // verticalSpace(allTransactions.isEmpty ? 250 : 0),

                        reloadData.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.primaryColor))
                            : reloadData.loadData.transactionHistory == null
                                ? Center(
                                    child: Text(
                                      'No data',
                                      style: AppTextStyles.font14.copyWith(
                                          color: AppColors.textColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : reloadData.loadData.transactionHistory!.data!
                                        .isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                height: 92.h,
                                                width: 92.w,
                                                child: Image.asset(
                                                    'assets/images/no_beneficiary_image.png')),
                                            verticalSpace(24),
                                            Text(
                                              'You have no transaction yet',
                                              style: AppTextStyles.font14
                                                  .copyWith(
                                                      color:
                                                          AppColors.textColor,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          TextInputField(
                                            controller: _searchController,
                                            hintText: 'Search in transactions',
                                            prefixIcon: const Icon(
                                              Icons.search,
                                              color: Color(0xff4F4F4F),
                                            ),
                                          ),
                                          verticalSpace(24),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropdownButton<Months>(
                                                underline: const SizedBox(),
                                                value: _selectedMonth,
                                                items: Months.values
                                                    .map((Months month) {
                                                  return DropdownMenuItem(
                                                      value: month,
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          child: Text(
                                                              _monthToString(
                                                                  month))));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _selectedMonth = newValue!;
                                                  });
                                                },
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  filterTransactionBottomSheet(
                                                      context);
                                                },
                                                child: const Row(
                                                  children: [
                                                    Text(
                                                      'Filter',
                                                      style:
                                                          AppTextStyles.font16,
                                                    ),
                                                    Icon(Icons
                                                        .filter_alt_outlined)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                         
                                          Column(
                                            children: List.generate(
                                              reloadData.loadData.autoRenewal!
                                                  .data!.length,
                                              (index) {
                                                final data = reloadData
                                                    .loadData
                                                    .transactionHistory!
                                                    .data![index];
                                                return GestureDetector(
                                                  onTap: () => nextScreen(
                                                      context,
                                                      TransactionDetailsScreen(
                                                        amount:
                                                            '${data.amountPaid}',
                                                        referenceId:
                                                            '${data.referenceId}',
                                                        status:
                                                            '${data.status}',
                                                        date: '${data.regDate}',
                                                        type: '${data.type}',
                                                      )),
                                                  child: Column(
                                                    children: [
                                                       ElevatedButton(
                                              onPressed: () {
                                                log('${reloadData.loadData.autoRenewal!.data![0].level}');
                                              },
                                              child: Text('')),
                                                      TransactionSection(
                                                          transactionIcon:
                                                              Icons.money,
                                                          transactionType:
                                                              '${data.subType}',
                                                          transactionDate:
                                                              '${data.regDate}',
                                                          transactionAmount:
                                                              'N${data.amountPaid}',
                                                          transactionStatus:
                                                              '${data.status}',
                                                          transactionColor:
                                                              Color(0xffD6DDFE),
                                                          transactionStatusColor: data
                                                                      .status ==
                                                                  'success'
                                                              ? Colors.green
                                                              : data.status ==
                                                                      'pending'
                                                                  ? Color(
                                                                      0xffA6B309)
                                                                  : Colors.red),
                                                      verticalSpace(8),
                                                      Divider(
                                                        color: AppColors
                                                            .blackColor
                                                            .withOpacity(0.1),
                                                      ),
                                                      verticalSpace(8),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                      ],
                    ),
                    isTapped
                        ? Positioned(
                            right: 0,
                            top: 30,
                            child: GestureDetector(
                              onTap: () => nextScreen(
                                  context, const AutoRenewalScreen()),
                              child: Container(
                                height: 54.h,
                                width: 158.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'View auto renewals',
                                  style: AppTextStyles.font14.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTextColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox()
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
