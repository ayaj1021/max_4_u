import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/add_customer_reg_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AddCustomerOtpScreen extends StatefulWidget {
  const AddCustomerOtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<AddCustomerOtpScreen> createState() => _AddCustomerOtpScreenState();
}

class _AddCustomerOtpScreenState extends State<AddCustomerOtpScreen> {
  final _otpController = TextEditingController();
  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCustomerProvider>(builder: (context, addCustomer, _) {
      return BusyOverlay(
        show: addCustomer.state == ViewState.Busy,
        title: addCustomer.message,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 41),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackArrowButton(
                      onTap: () => Navigator.pop(context),
                    ),
                    verticalSpace(26),
                    const Text(
                      'Verification Code',
                      style: AppTextStyles.font20,
                    ),
                    verticalSpace(12),
                    Text(
                      'Enter the 6-digit code sent to you at ${widget.phoneNumber}',
                      style: AppTextStyles.font14
                          .copyWith(color: const Color(0xff475569)),
                    ),
                    verticalSpace(24),
                    PinCodeTextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 6,
                      pinTheme: PinTheme(
                        inactiveColor: AppColors.borderColor,
                        fieldHeight: 48,
                        fieldWidth: 48,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    verticalSpace(40),
                    ButtonWidget(
                      text: 'Enter',
                      onTap: () async {
                        if (_otpController.text.isEmpty) {
                          showMessage(
                            context,
                            'Otp is required',
                            isError: true,
                          );
                          return;
                        }

                        await addCustomer.verifyCustomerOtp(
                            otp: _otpController.text.trim());
                        if (addCustomer.state == ViewState.Error &&
                            context.mounted) {
                          showMessage(
                            context,
                            addCustomer.message,
                            isError: true,
                          );
                          return;
                        }

                        if (addCustomer.state == ViewState.Success &&
                            context.mounted) {
                          showMessage(
                            context,
                            addCustomer.message,
                            // isError: false,
                          );
                          nextScreen(context, const AddCustomerRegScreen());
                        }
                      },
                    ),
                    verticalSpace(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Didn't get a code? ",
                    //       style: AppTextStyles.font14,
                    //     ),
                    //     horizontalSpace(10),
                    //     Text(
                    //       "00:30",
                    //       style: AppTextStyles.font14
                    //           .copyWith(color: AppColors.secondaryColor),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
