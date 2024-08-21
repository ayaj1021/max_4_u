import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/transaction_detail_screen.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';

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
