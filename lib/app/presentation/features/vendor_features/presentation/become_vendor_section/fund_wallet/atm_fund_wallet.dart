import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/fund_wallet/payment_gateway_screen.dart';
import 'package:max_4_u/app/provider/fund_account_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class AtmFundWallet extends StatefulWidget {
  const AtmFundWallet({super.key});

  @override
  State<AtmFundWallet> createState() => _AtmFundWalletState();
}

class _AtmFundWalletState extends State<AtmFundWallet> {
  final _amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<FundAccountProvider>(
      builder: (context, fundAcct, _) {
        return BusyOverlay(
          show: fundAcct.state == ViewState.Busy,
          title: fundAcct.message,
          child: Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      horizontalSpace(50),
                      Text(
                        'ATM Card (Fund Wallet)',
                        style: AppTextStyles.font18,
                      )
                    ],
                  ),
                  verticalSpace(64),
                  TextInputField(
                    controller: _amountController,
                    labelText: 'Amount to pay',
                    hintText: 'e.g 2500',
                    textInputType: TextInputType.number,
                  ),
                  verticalSpace(10),
                  Text(
                    'Additional charges will be added for this transaction.',
                    style: AppTextStyles.font14.copyWith(color: AppColors.greyColor),
                  ),
                  verticalSpace(40),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   height: 52.h,
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: AppColors.whiteColor,
                  //     border: Border.all(
                  //       color: const Color(0xffCBD5E1),
                  //     ),
                  //   ),
                  //   child: DropdownButton<PaymentPlatform>(
                  //     elevation: 0,
                  //     borderRadius: BorderRadius.circular(12),
                  //     underline: const SizedBox(),
                  //     value: _selectedPayment,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         _selectedPayment = newValue!;
                  //       });
                  //     },
                  //     items: PaymentPlatform.values
                  //         .map((PaymentPlatform paymentPlatform) {
                  //       return DropdownMenuItem(
                  //         value: paymentPlatform,
                  //         child: Container(
                  //           margin: const EdgeInsets.only(right: 240),
                  //           child: Container(
                  //             margin: const EdgeInsets.only(top: 8),
                  //             child: Text(
                  //               _paymentToString(paymentPlatform),
                  //               style: AppTextStyles.font14.copyWith(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w400,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  verticalSpace(80),
                  ButtonWidget(
                      text: 'Fund account',
                      onTap: () async {
                        if (_amountController.text.isEmpty) {
                          showMessage(context, 'Amount is required',
                              isError: true);

                          return;
                        }
                        await fundAcct.initializePayment(
                          amount: _amountController.text.trim(),
                        );

                        if (fundAcct.status == false && context.mounted) {
                          showMessage(context, fundAcct.message, isError: true);

                          return;
                        }

                        if (fundAcct.status == true && context.mounted) {
                          // showMessage(
                          //   context,
                          //   fundAcct.message,
                          //   // isError: false,
                          // );

                          nextScreen(
                              context,
                              PaymentGatewayScreen(
                                paymentUrl: fundAcct.paymentUrl,
                                token: fundAcct.token,
                              ));
                        }
                      }),
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
