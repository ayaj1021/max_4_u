import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/add_customer_otp_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class AddCustomerNumberScreen extends StatefulWidget {
  const AddCustomerNumberScreen({super.key});

  @override
  State<AddCustomerNumberScreen> createState() =>
      _AddCustomerNumberScreenState();
}

class _AddCustomerNumberScreenState extends State<AddCustomerNumberScreen> {
  final _phoneNumberController = TextEditingController();
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCustomerProvider>(
        builder: (context, addCustomer, _) {
      return BusyOverlay(
        show: addCustomer.state == ViewState.Busy,
        title: addCustomer.message,
        child: Scaffold(
            body: SafeArea(
                child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                ],
              ),
              verticalSpace(34),
              Text(
                'Enter Phone Number',
                style:
                    AppTextStyles.font20.copyWith(fontWeight: FontWeight.w500),
              ),
              verticalSpace(14),
              Text(
                'Input customers phone number to get started',
                style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.textColor,
                ),
              ),
              verticalSpace(12),
              TextInputField(
                controller: _phoneNumberController,
                labelText: 'Phone number',
              ),
              verticalSpace(64),
              ButtonWidget(
                onTap: () async {
                  if (_phoneNumberController.text.isEmpty) {
                    showMessage(context, 'Phone number is required',
                        isError: true);
                    return;
                  }
                  await addCustomer.addCustomerWithNumber(
                    phoneNumber: _phoneNumberController.text.trim(),
                  );

                  if (addCustomer.status == false && context.mounted) {
                    showMessage(
                      context,
                      addCustomer.message,
                      isError: true,
                    );

                    return;
                  }

                  if (addCustomer.status == true && context.mounted) {
                    showMessage(
                      context,
                      addCustomer.message,
                      // isError: false,
                    );
                    nextScreen(
                        context,
                        AddCustomerOtpScreen(
                          phoneNumber: _phoneNumberController.text,
                        ));
                  }
                },
                text: 'Continue',
              )
            ],
          ),
        ))),
      );
    });
  }
}
