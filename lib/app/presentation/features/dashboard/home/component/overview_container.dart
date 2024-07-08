import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class OverViewContainer extends StatefulWidget {
  const OverViewContainer({super.key});

  @override
  State<OverViewContainer> createState() => _OverViewContainerState();
}

class _OverViewContainerState extends State<OverViewContainer> {
  @override
  void initState() {
    getAllTransactions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  List allTransactions = [];
  getAllTransactions() async {
    final transactions = await SecureStorage().getUserTransactionHistory();
    setState(() {
      allTransactions = transactions;
    });
    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllCustomersProvider, ReloadUserDataProvider>(
        builder: (context, getCustomers, reloadData, _) {
      return reloadData.loadData.transactionHistory!.data == null
          ? SizedBox.shrink()
          : Container(
              height: 103.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 19),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'Total transactions',
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      verticalSpace(12),
                      Text(
                        '${reloadData.loadData.transactionHistory!.data!.length}',
                        style: AppTextStyles.font16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff333333)),
                      ),
                    ],
                  ),
                  VerticalDivider(color: AppColors.blackColor.withOpacity(0.1)),
                  Column(
                    children: [
                      Text(
                        'Total customers',
                        style: AppTextStyles.font14.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      verticalSpace(12),
                      // getCustomers.data == null ? SizedBox.shrink() :
                      Text(
                        '${getCustomers.data.length}',
                        style: AppTextStyles.font16.copyWith(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff333333)),
                      ),
                    ],
                  ),
                ],
              ),
            );
    });
  }
}
