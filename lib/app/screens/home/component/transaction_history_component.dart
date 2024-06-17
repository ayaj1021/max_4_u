import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
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
  List getTransactions = [];

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
    final transactions = await SecureStorage().getUserTransactions();
    setState(() {
      getTransactions = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('MMMM d, yyyy h:mm a');
    return Consumer2<AuthProviderImpl, ReloadUserDataProvider>(
        builder: (context, authProv, reloadData, _) {
      return Container(
          height: 241.h,
          width: 358.w,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor),
          child: reloadData.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                )
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
                            return TransactionSection(
                              transactionStatusColor: data.status == 'success'
                                  ? Colors.green
                                  : data.status == 'pending'
                                      ? Color(0xffA6B309)
                                      : Colors.red,
                              transactionIcon: Icons.call_outlined,
                              transactionType: data.subType.toString(),
                              transactionDate:
                                  '${dateFormat.format(data.regDate!)}',
                              transactionAmount: 'N${data.productAmount ?? 0}',
                              transactionStatus: data.status.toString(),
                              transactionColor: Color(0xffDEEDF7),
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
  });
  final IconData transactionIcon;
  final String transactionType;
  final String transactionDate;
  final String transactionAmount;
  final String transactionStatus;
  final Color transactionStatusColor;
  final Color transactionColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transactionColor,
                  ),
                  child: Icon(transactionIcon),
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
        verticalSpace(24),
      ],
    );
  }
}
