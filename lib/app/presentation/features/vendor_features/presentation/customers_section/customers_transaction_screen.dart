import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_user_transactions_by_id_provider.dart';
import 'package:max_4_u/app/presentation/features/dashboard/home/component/transaction_history_component.dart';
import 'package:max_4_u/app/presentation/features/dashboard/transaction/presentation/views/widgets/empty_transaction_section.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class CustomerTransactionScreen extends StatefulWidget {
  const CustomerTransactionScreen({super.key});

  @override
  State<CustomerTransactionScreen> createState() =>
      _CustomerTransactionScreenState();
}

class _CustomerTransactionScreenState extends State<CustomerTransactionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetUserTransactionProvider>(context, listen: false)
          .userTransactionsById(userId: '1');
    });

    super.initState();
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
    return Consumer<GetUserTransactionProvider>(
      builder: (context, userTransaction, _) {
        final dataList = userTransaction.userTransactions.data?.responseData!;
        return SingleChildScrollView(
          child: Column(
            children: [
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
                      ? EmptyTransactionSection()
                      : SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: dataList.length,
                              // userTransaction.userTransactions.data?.responseData?.length,
                              itemBuilder: (_, index) {
                                final data = userTransaction.userTransactions
                                    .data?.responseData?[index];

                                return Column(children: [
                                  TransactionSection(
                                    transactionIcon: icons[2],
                                    transactionType: '${data?.purchaseType}',
                                    transactionDate:
                                        '${dateFormat.format(data?.regDate as DateTime)}',
                                    transactionAmount: 'N${data?.amountPaid}',
                                    transactionStatus: '${data?.status}',
                                    transactionColor: Color(0xffD6DDFE),
                                    transactionStatusColor:
                                        data?.status == 'success'
                                            ? Colors.green
                                            : data?.status == 'pending'
                                                ? Color(0xffA6B309)
                                                : Colors.red,
                                    transactionNumber: '${data?.number ?? ''}',
                                  ),
                                  verticalSpace(8),
                                  Divider(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                  )
                                ]);
                              }),
                        ),
            ],
          ),
        );
      },
    );
  }
}
