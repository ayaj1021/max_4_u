import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/text_capitalization_extension.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class TransactionHistoryContainer extends StatefulWidget {
  const TransactionHistoryContainer({
    super.key, 
  });


  @override
  State<TransactionHistoryContainer> createState() =>
      _TransactionHistoryContainerState();
}

class _TransactionHistoryContainerState
    extends State<TransactionHistoryContainer> {
  TransactionHistory? retrievedTransactionHistory;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    getAllTransactions();
    super.initState();
  }

  getAllTransactions() async {
    // final transactions = await SecureStorage().getUserTransactions();
    final storage = await SecureStorage();

    retrievedTransactionHistory = (await storage.getUserTransactions())!;
    // Assuming SecureStorage is an async operation, you'll need to await its creation
// final storage = SecureStorage();

// // Fetch user transactions safely
// var transactionHistory = await storage.getUserTransactions();

// if (transactionHistory != null) {
//   // Assign the retrieved transactions if not null
//   retrievedTransactionHistory = transactionHistory;
// } else {
//   // Handle the case when transactions are null (e.g., assign an empty list)
//   retrievedTransactionHistory = [];
//   print('No transactions found.');
// }

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
    return Consumer2<AuthProviderImpl, ReloadUserDataProvider>(
        builder: (context, authProv, reloadData, _) {
      return Container(
       //   height: 280.h,
          width: 358.w,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor),
          child: reloadData.loadData.transactionHistory!.data == null
              ? SizedBox.shrink()
              : reloadData.loadData.transactionHistory!.data!.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 52.h,
                              width: 52.w,
                              child: Image.asset(
                                  'assets/images/no_beneficiary_image.png')),
                          verticalSpace(24),
                          Text(
                            'You have no transaction history',
                            style: AppTextStyles.font14.copyWith(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    )
                  : Column(
                      children: List.generate(
                        3,
                        (index) {
                          if (index <
                              reloadData
                                  .loadData.transactionHistory!.data!.length) {
                            final data = reloadData
                                .loadData.transactionHistory!.data![index];
                            return Column(
                              children: [
                                TransactionSection(
                                  transactionStatusColor:
                                      data.status == 'success'
                                          ? Colors.green
                                          : data.status == 'pending'
                                              ? Color(0xffA6B309)
                                              : Colors.red,
                                  transactionIcon:
                                      data.subType!.contains('card')
                                          ? icons[2]
                                          : data.subType!.contains('data')
                                              ? icons[1]
                                              : icons[0],
                                  transactionType:
                                      data.subType.toString().capitalize(),
                                  transactionDate:
                                      '${dateFormat.format(data.regDate!)}',
                                  transactionAmount: 'N${data.amountPaid ?? 0}',
                                  transactionStatus: data.status.toString(),
                                  transactionColor:
                                      data.subType!.contains('card')
                                          ? colors[1]
                                          : data.subType!.contains('data')
                                              ? colors[2]
                                              : colors[0],

                                  // Color(0xffDEEDF7),
                                  transactionNumber:
                                      '${data.number ?? '' '${data.referenceId?.substring(data.referenceId!.length - 5) ?? ''} '}',
                                ),
                                verticalSpace(2),
                                Divider(
                                  color: Colors.grey.withOpacity(0.3),
                                )
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    )

          // Column(
          //     children: [
          //       const TransactionSection(
          //         transactionIcon: Icons.call_outlined,
          //         transactionType: 'Airtime',
          //         transactionDate: 'Apr 18th, 20:59',
          //         transactionAmount: '-N35,000.00',
          //         transactionStatus: 'Successful',
          //         transactionColor: Color(0xffDEEDF7),
          //       ),
          //       verticalSpace(24),

          //     ],
          //   ),
          );
    });
  }
}

class TransactionSection extends StatelessWidget {
  const TransactionSection({
    super.key,
    required this.transactionIcon,
    required this.transactionType,
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionStatus,
    required this.transactionColor,
    required this.transactionStatusColor,
    required this.transactionNumber,
  });
  final String transactionIcon;
  final String transactionType;
  final String transactionDate;
  final String transactionAmount;
  final String transactionNumber;
  final String transactionStatus;
  final Color transactionStatusColor;
  final Color transactionColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45.h,
                    width: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: transactionColor,
                    ),
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset(transactionIcon)),
                  ),
                  horizontalSpace(9),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionType,
                        style: AppTextStyles.font18
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                      Text(
                        transactionNumber,
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        transactionDate,
                        style: AppTextStyles.font12.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    transactionAmount,
                    style: AppTextStyles.font14
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    transactionStatus,
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w400,
                      color: transactionStatusColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        // verticalSpace(24),
      ],
    );
  }
}
