import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/enums/month_dropdown_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/transaction_detail_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/widgets/filter_transaction_bottom_sheet.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TransactionListSection extends StatefulWidget {
  const TransactionListSection({
    super.key,
    required TextEditingController searchController,
    required this.filteredTransactions,
    required this.dateFormat,
    required this.icons,
    required this.colors,
    required this.filterItems,
    required this.allItems,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  final List<Transaction>? filteredTransactions;
  final DateFormat dateFormat;
  final List icons;
  final List colors;
  final void Function(String) filterItems;
  final void Function(String) allItems;

  @override
  State<TransactionListSection> createState() => _TransactionListSectionState();
}

class _TransactionListSectionState extends State<TransactionListSection> {
  //var _selectedMonth = Months.January;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextInputField(
          controller: widget._searchController,
          hintText: 'Search in transactions',
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xff4F4F4F),
          ),
        ),
        verticalSpace(18),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // DropdownButton<Months>(
            //   underline: const SizedBox(),
            //   value: _selectedMonth,
            //   items: Months.values.map((Months month) {
            //     return DropdownMenuItem(
            //         value: month,
            //         child: Container(
            //             padding: EdgeInsets.zero,
            //             child: Text(_monthToString(month))));
            //   }).toList(),
            //   onChanged: (newValue) {
            //     setState(() {
            //       _selectedMonth = newValue!;
            //     });
            //   },
            // ),
            GestureDetector(
              onTap: () {
                filterTransactionBottomSheet(context,
                    filterItems: widget.filterItems, allItems: widget.allItems);
              },
              child: Row(
                children: [
                  Text(
                    'Filter',
                    style: AppTextStyles.font16,
                  ),
                  Icon(Icons.filter_alt_outlined)
                ],
              ),
            )
          ],
        ),
        widget.filteredTransactions!.isEmpty
            ? Center(
              child: Text(
                  'Not found',
                  style: AppTextStyles.font18.copyWith(
                      color: AppColors.textColor, fontWeight: FontWeight.w400),
                ),
            )
            : Column(
                children: List.generate(
                  // data.length,
                  widget.filteredTransactions?.length ?? 0,
                  (index) {
                    final data = widget.filteredTransactions!;

                    return InkWell(
                      onTap: () => nextScreen(
                          context,
                          TransactionDetailsScreen(
                            amount: '${data[index].amountPaid}',
                            referenceId: '${data[index].referenceId}',
                            status: '${data[index].status}',
                            date:
                                '${widget.dateFormat.format(data[index].regDate as DateTime)}',
                            type: '${data[index].type}',
                            number: '${data[index].number}',
                            subType: '${data[index].subType}',
                          )),
                      child: Column(
                        children: [
                          TransactionSection(
                            transactionIcon:
                                data[index].subType!.contains('card')
                                    ? widget.icons[2]
                                    : data[index].subType!.contains('data')
                                        ? widget.icons[1]
                                        : widget.icons[0],
                            transactionType:
                                '${data[index].subType}'.capitalize(),
                            transactionDate:
                                '${widget.dateFormat.format(data[index].regDate as DateTime)}',
                            transactionAmount: 'N${data[index].amountPaid}',
                            transactionStatus: '${data[index].status}',
                            transactionColor:
                                data[index].subType!.contains('card')
                                    ? widget.colors[1]
                                    : data[index].subType!.contains('data')
                                        ? widget.colors[2]
                                        : widget.colors[0],
                            // Color(0xffD6DDFE),
                            transactionStatusColor:
                                data[index].status == 'success'
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

String monthToString(Months month) {
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
