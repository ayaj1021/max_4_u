import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/saved_customers_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/provider/buy_airtime_provider.dart';

import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/airtime_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SellAirtimeScreen extends StatefulWidget {
  const SellAirtimeScreen({super.key});

  @override
  State<SellAirtimeScreen> createState() => _SellAirtimeScreenState();
}

class _SellAirtimeScreenState extends State<SellAirtimeScreen> {
  String? _selectedNetwork = networkProviders[0];

  final _amountController = TextEditingController();
  final _phoneNumber = TextEditingController();

  final amount = [
    '100',
    '200',
    '500',
    '1000',
    '2000',
    '5000',
  ];
  String network = '';

  int? selectedIndex;

  String airtimeAmount = '';
  @override
  void dispose() {
    _phoneNumber.dispose();
    super.dispose();
  }

  var codeValues = [];
  var networks = [];
  getProductCodeValues() async {
   // final code = await SecureStorage().getUserProducts();
     final storage = await SecureStorage();
    final code = await storage.getUserProducts();
    final network = code!
        .where((code) => code.name == 'mtn')
        .map((code) => code.code)
        .toList();

    final productCodes = code
        .where((code) => code.category == 'airtime')
        .map((code) => code.code)
        .toList();

    setState(() {
      networks = network;
      codeValues = productCodes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyAirtimeProvider>(
      builder: (context, buyAirtime, _) {
        return BusyOverlay(
          show: buyAirtime.state == ViewState.Busy,
          title: buyAirtime.message,
          child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
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
                         Text(
                          'Airtime Sales',
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
                        // hint: Text('MTN'),
                        elevation: 0,
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12),
                        underline: const SizedBox(),
                        value: _selectedNetwork,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedNetwork = newValue!;
                          });
                        },
                        items: networkProviders.map((String networkProviders) {
                          return DropdownMenuItem(
                            value: networkProviders,
                            onTap: () {
                              // setState(() {
                              //   network =
                              //       _networkToString(network) as NetworkProvider;
                              // });
                            },
                            child: Text(
                              networkProviders.toUpperCase(),
                              style: AppTextStyles.font14.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
                          controller: _phoneNumber,
                          labelText: 'Phone Number',
                          hintText: 'receiver\'s number',
                          textInputType: TextInputType.number,
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () =>
                                nextScreen(context, const SavedCustomersScreen()),
                            child: Text(
                              'select from customers',
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
                    // ElevatedButton(onPressed: (){

                    //   getNetworkList();
                    // }, child: Text('')),
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
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;

                                  airtimeAmount =
                                      amount[selectedIndex!.toInt()];
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 42.h,
                                width: 96.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? AppColors.primaryColor
                                        : const Color(0xffCBD5E1),
                                  ),
                                ),
                                child: Text(
                                  'N${amount[index]}',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    verticalSpace(14),
                    TextInputField(
                      controller: _amountController,
                      hintText: '50-350,000',
                      textInputType: TextInputType.number,
                      onChanged: (p0) {
                        airtimeAmount = _amountController.text;
                      },
                    ),
                    verticalSpace(68),
                    ButtonWidget(
                      text: 'Continue',
                      onTap: () async {
                        if (_phoneNumber.text.isEmpty) {
                          showMessage(context, 'Phone number is required',
                              isError: true);
                          return;
                        }

                        if (airtimeAmount.isEmpty) {
                          showMessage(context, 'Amount is required',
                              isError: true);
                          return;
                        }

                        nextScreen(
                            context,
                            AirtimeVerificationScreen(
                              network: '${_selectedNetwork}',
                              phoneNumber: _phoneNumber.text.trim(),
                              amount: airtimeAmount,
                            ));
                      },
                    )
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
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
