import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class TransactionsComponent extends StatefulWidget {
  const TransactionsComponent({super.key});

  @override
  State<TransactionsComponent> createState() => _TransactionsComponentState();
}

class _TransactionsComponentState extends State<TransactionsComponent> {

  final List icons = [
    'assets/icons/call_icon.png',
    'assets/icons/data_icon.png',
    'assets/icons/fund_wallet_icon.png',
  ];
  @override
  Widget build(BuildContext context) {
      DateFormat dateFormat = DateFormat('MMMM d, yyyy h:mm a');
    return Consumer2<GetAllAppUsers, ReloadUserDataProvider>(
      builder: (context, getAllApps, reloadData, _) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(reloadData.loadData.transactionHistory!.data!.length, (index) {
              final data = reloadData.loadData.transactionHistory!.data![index];
              //getAllApps.allAppUsers.data![index];
              return Column(children: [
                TransactionSection(
                    transactionIcon: icons[2],
                    transactionType: '${data.purchaseType}',
                    transactionDate:
                        '${dateFormat.format(data.regDate as DateTime)}',
                    transactionAmount: 'N${data.amountPaid}',
                    transactionStatus: '${data.status}',
                    transactionColor: Color(0xffD6DDFE),
                    transactionStatusColor: data.status == 'success'
                        ? Colors.green
                        : data.status == 'pending'
                            ? Color(0xffA6B309)
                            : Colors.red, transactionNumber: '${data.number}',),
                verticalSpace(8),
                Divider(
                  color: AppColors.blackColor.withOpacity(0.1),
                )
              ]);
            }),
          ),
        );
      },
    );
  }
}
