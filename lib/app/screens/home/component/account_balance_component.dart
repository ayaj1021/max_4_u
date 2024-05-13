import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class AccountBalanceWidget extends StatefulWidget {
  const AccountBalanceWidget({
    super.key,
  });

  @override
  State<AccountBalanceWidget> createState() => _AccountBalanceWidgetState();
}

class _AccountBalanceWidgetState extends State<AccountBalanceWidget> {
  List walletType = [
    {
      "title": "ATM Card",
      "image": "assets/images/atm_card_icon.png",
    },
    {
      "title": "Account NO",
      "image": "assets/images/account_no_icon.png",
    },
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 32),
      height: 125.h,
      width: 358.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  'Wallet Balance',
                  style: AppTextStyles.font12.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
                horizontalSpace(5),
                const Icon(
                  Icons.visibility_off_outlined,
                  size: 12,
                  color: AppColors.whiteColor,
                )
              ],
            ),
            verticalSpace(12),
            Text(
              '₦350,000,000',
              style: AppTextStyles.font12.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.whiteColor,
              ),
            ),
          ]),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
                        height: 209.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Fund wallet using',
                              style: AppTextStyles.font18.copyWith(
                                color: const Color(0xff333333),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpace(28),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children:
                                    List.generate(walletType.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex == index;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 16),
                                      height: 98.h,
                                      width: 116.2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: selectedIndex == index
                                              ? AppColors.whiteColor
                                              : const Color(0xffF6F6F6),
                                          border: Border.all(
                                            color: selectedIndex == index
                                                ? AppColors.primaryColor
                                                : Colors.transparent,
                                          )),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child: Image.asset(
                                                walletType[index]['image']),
                                          ),
                                          verticalSpace(19),
                                          Text(
                                            walletType[index]['title'],
                                            style:
                                                AppTextStyles.font14.copyWith(
                                              color: const Color(0xff333333),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Container(
              alignment: Alignment.center,
              height: 36.h,
              width: 104.w,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Fund wallet',
                style: AppTextStyles.font14.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
