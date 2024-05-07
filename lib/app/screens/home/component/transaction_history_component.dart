import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TransactionHistoryContainer extends StatelessWidget {
  const TransactionHistoryContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 221.h,
      width: 358.w,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.whiteColor),
      child: Column(
        children: [
          const TransactionSection(
            transactionIcon: Icons.call_outlined,
            transactionType: 'Airtime',
            transactionDate: 'Apr 18th, 20:59',
            transactionAmount: '-N35,000.00',
            transactionStatus: 'Successful', transactionColor: Color(0xffDEEDF7),
          ),
          verticalSpace(24),
          const TransactionSection(
            transactionIcon: Icons.money,
            transactionType: 'Added funds',
            transactionDate: 'Apr 18th, 20:59',
            transactionAmount: '-N35,000.00',
            transactionStatus: 'Successful',
            transactionColor: Color(0xffD6DDFE),
          ),
          verticalSpace(24),
          const TransactionSection(
            transactionIcon: Icons.network_wifi_outlined,
            transactionType: 'Data',
            transactionDate: 'Apr 18th, 20:59',
            transactionAmount: '-N35,000.00',
            transactionStatus: 'Successful',
            transactionColor: Color(0xffE8D6FE),
          ),
        ],
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  const TransactionSection({
    super.key,
    required this.transactionIcon,
    required this.transactionType,
    required this.transactionDate,
    required this.transactionAmount,
    required this.transactionStatus, required this.transactionColor,
  });
  final IconData transactionIcon;
  final String transactionType;
  final String transactionDate;
  final String transactionAmount;
  final String transactionStatus;
  final Color transactionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              alignment: Alignment.center,
              decoration:  BoxDecoration(
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
                  style: AppTextStyles.font14,
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
              style: AppTextStyles.font14,
            ),
            Text(
              transactionStatus,
              style: AppTextStyles.font12.copyWith(
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ),
            ),
          ],
        )
      ],
    );
  }
}
