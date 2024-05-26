import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/data_period_enum.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/screens/beneficiary/beneficiary_screen.dart';
import 'package:max_4_u/app/screens/buy_data/data_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class BuyDataScreen extends StatefulWidget {
  const BuyDataScreen({super.key});

  @override
  State<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends State<BuyDataScreen> {
  String _selectedNetwork = networkProvider[0];

  DataPeriod _selectedPeriod = DataPeriod.Daily;
  final _phoneNumberController = TextEditingController();

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
                  horizontalSpace(113),
                  const Text(
                    'Buy Data',
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
                child: DropdownButton<String>(
               
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  underline: const SizedBox(),
                  value: _selectedNetwork,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedNetwork = newValue!;
                    });
                  },
                  items: networkProvider.map((String networkProviders) {
                    return DropdownMenuItem(
                      value: networkProviders,
                      child: Container(
                        margin: const EdgeInsets.only(right: 250),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            networkProviders,
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
              verticalSpace(27),
              Text(
                'Data Usage Periods',
                style: AppTextStyles.font14.copyWith(
                  color: const Color(0xff475569),
                  fontWeight: FontWeight.w500,
                ),
              ),
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
                child: DropdownButton<DataPeriod>(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12),
                  underline: const SizedBox(),
                  value: _selectedPeriod,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedPeriod = newValue!;
                    });
                  },
                  items: DataPeriod.values.map((DataPeriod data) {
                    return DropdownMenuItem(
                      value: data,
                      child: Container(
                        margin: const EdgeInsets.only(right: 270),
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Text(
                            _dataPeriodToString(data),
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
              verticalSpace(278),
              ButtonWidget(
                text: 'Continue',
                onTap: () => nextScreen(
                  context,
                  const DataVerificationScreen(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

String _dataPeriodToString(DataPeriod data) {
  switch (data) {
    case DataPeriod.Daily:
      return 'Daily';
    case DataPeriod.Monthly:
      return 'Monthly';
    case DataPeriod.Weekly:
      return 'Weekly';
    case DataPeriod.Yearly:
      return 'Yearly';

    default:
      return '';
  }
}

// String _networkToString(networkProvider network) {
//   switch (network) {
//     case networkProvider.MTN:
//       return 'MTN';
//     case networkProvider.GLO:
//       return 'GLO';
//     case networkProvider.Airtel:
//       return 'Airtel';
//     case networkProvider.Etisalat:
//       return 'Etisalat';

//     default:
//       return '';
//   }
// }
