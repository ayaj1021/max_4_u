import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:max_4_u/app/presentation/features/vendor_features/presentation/vendor_sections/become_vendor_section/fund_wallet/account_no_payment_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/vendor_sections/become_vendor_section/fund_wallet/atm_fund_wallet.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class AccountBalanceWidget extends StatefulWidget {
  const AccountBalanceWidget({
    super.key,
  });

  @override
  State<AccountBalanceWidget> createState() => _AccountBalanceWidgetState();
}

class _AccountBalanceWidgetState extends State<AccountBalanceWidget> {
  String balance = '';

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Provider.of<ReloadUserDataProvider>(context, listen: false)
    //       .reloadUserData();
    // });
    super.initState();
  }

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
    return Consumer3<AuthProviderImpl, ObscureTextProvider,
            ReloadUserDataProvider>(
        builder: (context, authProv, obscure, reloadData, _) {
      final accountBalance = reloadData.loadData.userAccount!.balance;
      String totalBalance = NumberFormat('#,##0').format(accountBalance);
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
                  GestureDetector(
                    onTap: () => obscure.changeObscure(),
                    child: Icon(
                      obscure.isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 12,
                      color: AppColors.whiteColor,
                    ),
                  )
                ],
              ),
              verticalSpace(12),
              // accountBalance == null
              //     ? Text('')
              //     :
              Text(
                obscure.isObscure ? '*****' : 'N${totalBalance}.00',
                style: AppTextStyles.font12.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: AppColors.whiteColor,
                ),
              ),
            ]),
            GestureDetector(
              onTap: () {
                authProv.userLevel != '2'
                    ? nextScreen(context, const AtmFundWallet())
                    : showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 24),
                              height: 250.h,
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

                                  SizedBox(
                                    height: 100.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: walletType.length,
                                        itemBuilder: (_, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              selectedIndex == 0
                                                  ? nextScreen(context,
                                                      const AtmFundWallet())
                                                  : authProv.userLevel == '2'
                                                      ? nextScreen(context,
                                                          const AccountNoPaymentScreen())
                                                      : SizedBox.shrink();

                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 16),
                                                  height: 98.h,
                                                  width: 116.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: selectedIndex ==
                                                              index
                                                          ? AppColors.whiteColor
                                                          : const Color(
                                                              0xffF6F6F6),
                                                      border: Border.all(
                                                        color: selectedIndex ==
                                                                index
                                                            ? AppColors
                                                                .primaryColor
                                                            : Colors
                                                                .transparent,
                                                      )),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 20.h,
                                                        width: 20.w,
                                                        child: Image.asset(
                                                            walletType[index]
                                                                ['image']),
                                                      ),
                                                      verticalSpace(19),
                                                      Text(
                                                        walletType[index]
                                                            ['title'],
                                                        style: AppTextStyles
                                                            .font14
                                                            .copyWith(
                                                          color: const Color(
                                                              0xff333333),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                horizontalSpace(90)
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  // Row(
                                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //     children:
                                  //         List.generate(walletType.length, (index) {
                                  //       return
                                  //       GestureDetector(
                                  //         onTap: () {
                                  //           setState(() {
                                  //             selectedIndex == index;
                                  //           });
                                  //         },
                                  //         child:
                                  //         Container(
                                  //           padding: const EdgeInsets.symmetric(
                                  //               horizontal: 5, vertical: 16),
                                  //           height: 98.h,
                                  //           width: 116.2,
                                  //           decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(10),
                                  //               color: selectedIndex == index
                                  //                   ? AppColors.whiteColor
                                  //                   : const Color(0xffF6F6F6),
                                  //               border: Border.all(
                                  //                 color: selectedIndex == index
                                  //                     ? AppColors.primaryColor
                                  //                     : Colors.transparent,
                                  //               )),
                                  //           child: Column(
                                  //             children: [
                                  //               SizedBox(
                                  //                 height: 20.h,
                                  //                 width: 20.w,
                                  //                 child: Image.asset(
                                  //                     walletType[index]['image']),
                                  //               ),
                                  //               verticalSpace(19),
                                  //               Text(
                                  //                 walletType[index]['title'],
                                  //                 style: AppTextStyles.font14.copyWith(
                                  //                   color: const Color(0xff333333),
                                  //                   fontWeight: FontWeight.w500,
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       );

                                  //     })),
                                ],
                              ),
                            );
                          });
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
    });
  }
}
