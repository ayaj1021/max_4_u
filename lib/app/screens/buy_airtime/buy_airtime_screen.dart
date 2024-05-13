import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/screens/beneficiary/beneficiary_screen.dart';
import 'package:max_4_u/app/screens/buy_airtime/airtime_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class BuyAirtimeScreen extends StatefulWidget {
  const BuyAirtimeScreen({super.key});

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
  NetworkProvider _selectedNetwork = NetworkProvider.MTN;
  final _phoneNumberController = TextEditingController();
  final _amountController = TextEditingController();

  final amount = [
    '#100',
    '#200',
    '#500',
    '#1000',
    '#2000',
    '#5000',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
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
                  horizontalSpace(104),
                  const Text(
                    'Buy Airtime',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(64),
              Text(
                'Select Network',
                style: AppTextStyles.font14.copyWith(
                  color: const Color(0xff475569),
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 52.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.whiteColor,
                  border: Border.all(
                    color: const Color(0xffCBD5E1),
                  ),
                ),
                child: DropdownButton<NetworkProvider>(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  underline: const SizedBox(),
                  value: _selectedNetwork,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedNetwork = newValue!;
                    });
                  },
                  items: NetworkProvider.values.map((NetworkProvider network) {
                    return DropdownMenuItem(
                      value: network,
                      child: Container(
                        margin: const EdgeInsets.only(right: 275),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            _networkToString(network),
                            style: AppTextStyles.font14.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              verticalSpace(30),
              Stack(
                children: [
                  TextInputField(
                    controller: _phoneNumberController,
                    labelText: 'Phone Number',
                    hintText: 'receiver\'s number',
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () =>
                          nextScreen(context, const BeneficiaryScreen()),
                      child: Text(
                        'select from beneficiary',
                        style: AppTextStyles.font12.copyWith(
                          color: AppColors.secondaryColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(30),
              Text(
                'Amount',
                style: AppTextStyles.font14.copyWith(
                  color: const Color(0xff475569),
                  fontWeight: FontWeight.w500,
                ),
              ),
              verticalSpace(10),
              SizedBox(
                height: 100.h,
                child: GridView.builder(
                    itemCount: amount.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 35,
                      childAspectRatio: 2.3,
                    ),
                    itemBuilder: (_, index) {
                      return Container(
                        alignment: Alignment.center,
                        height: 42.h,
                        width: 96.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.whiteColor,
                          border: Border.all(
                            color: const Color(0xffCBD5E1),
                          ),
                        ),
                        child: Text(
                          amount[index],
                          style: AppTextStyles.font14.copyWith(
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
              ),
              verticalSpace(14),
              TextInputField(
                controller: _amountController,
                hintText: '50-350,000',
              ),
              verticalSpace(68),
              ButtonWidget(
                text: 'Continue',
                onTap: () => nextScreen(
                  context,
                  const AirtimeVerificationScreen(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

String _networkToString(NetworkProvider network) {
  switch (network) {
    case NetworkProvider.MTN:
      return 'MTN';
    case NetworkProvider.GLO:
      return 'GLO';
    case NetworkProvider.Airtel:
      return 'Airtel';
    case NetworkProvider.Etisalat:
      return 'Etisalat';

    default:
      return '';
  }
}
