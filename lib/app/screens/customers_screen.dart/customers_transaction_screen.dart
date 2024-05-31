import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/month_dropdown_enum.dart';
import 'package:max_4_u/app/screens/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class CustomerTransactionScreen extends StatefulWidget {
  const CustomerTransactionScreen({super.key});

  @override
  State<CustomerTransactionScreen> createState() =>
      _CustomerTransactionScreenState();
}

class _CustomerTransactionScreenState extends State<CustomerTransactionScreen> {
  Months _selectedMonth = Months.January;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<Months>(
              underline: const SizedBox(),
              value: _selectedMonth,
              items: Months.values.map((Months month) {
                return DropdownMenuItem(
                    value: month,
                    child: Container(
                        padding: EdgeInsets.zero,
                        child: Text(_monthToString(month))));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedMonth = newValue!;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 21),
                        height: 508.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            color: AppColors.whiteColor),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child:
                                    Image.asset('assets/icons/cancel_icon.png'),
                              ),
                            ),
                            verticalSpace(2),
                          ],
                        ),
                      );
                    });
              },
              child: const Row(
                children: [
                  Text(
                    'Filter',
                    style: AppTextStyles.font16,
                  ),
                  Icon(Icons.filter_alt_outlined)
                ],
              ),
            ),
          ],
        ),
        verticalSpace(25),
        Expanded(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      // onTap: () => nextScreen(
                      //     context, const TransactionDetailsScreen()),
                      child: Column(
                        children: [
                          const TransactionSection(
                            transactionIcon: Icons.money,
                            transactionType: 'Added funds',
                            transactionDate: 'Apr 18th, 20:59',
                            transactionAmount: '-N35,000.00',
                            transactionStatus: 'Successful',
                            transactionColor: Color(0xffD6DDFE), transactionStatusColor: Colors.green,
                          ),
                          verticalSpace(8),
                          Divider(
                            color: AppColors.blackColor.withOpacity(0.1),
                          ),
                          verticalSpace(8),
                        ],
                      ),
                    );
                  })),
        ),
       
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
