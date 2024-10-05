import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/airtime_verification_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/widgets/input_phone_number_beneficiary_widget.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/widgets/select_amount_section.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';

import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class BuyAirtimeScreen extends StatefulWidget {
  const BuyAirtimeScreen({super.key});

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
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

  List<Product> retrievedProducts = [];
  String network = '';

  int? selectedIndex;

  String airtimeAmount = '';

  String? selectedLogo;

  void handleLogoSelection(String logo) {
    setState(() {
      selectedLogo = logo;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor, // Set your desired status bar color here
        statusBarIconBrightness: Brightness.light, // Set light or dark icons
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _amountController.dispose();

    super.dispose();
  }

  String? _selectedProvider;

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
                          'Buy Airtime',
                          style: AppTextStyles.font18,
                        )
                      ],
                    ),
                    verticalSpace(64),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      // height: 52.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: const Color(0xffCBD5E1),
                        ),
                      ),
                      child: DropdownButton<String>(
                        underline: SizedBox.shrink(),
                        isExpanded: true,
                        hint: Text('Select Network'),
                        value: _selectedProvider,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProvider = newValue;
                          });
                        },
                        items: networkProviders.map((String provider) {
                          return DropdownMenuItem<String>(
                            value: provider,
                            child: Text(provider.toUpperCase()),
                          );
                        }).toList(),
                      ),

                      // DropdownMenu(
                      //   hintText: 'Select network',
                      //   width: 330.w,
                      //   inputDecorationTheme: InputDecorationTheme(
                      //     fillColor: AppColors.whiteColor,
                      //     border: InputBorder.none,
                      //   ),
                      //   onSelected: (newValue) {
                      //     setState(() {
                      //       widget.selectedNetwork = newValue!;
                      //     });
                      //   },
                      //   dropdownMenuEntries:
                      //       widget.network.map((String networkProviders) {
                      //     return DropdownMenuEntry(
                      //       value: networkProviders,
                      //       label: networkProviders.toUpperCase(),
                      //     );
                      //   }).toList(),
                      // ),
                    ),
                    verticalSpace(30),
                    InputPhoneNumberAndBeneficiaryWidget(
                        phoneNumber: _phoneNumber),
                    verticalSpace(30),
                    SelectAmountSection(
                      amount: amount,
                      phoneNumber: _phoneNumber,
                      amountController: _amountController,
                      selectedNetwork: _selectedProvider.toString(),
                    ),
                    verticalSpace(68),
                    ButtonWidget(
                      text: 'Continue',
                      onTap: () async {
                         if (_selectedProvider == null ) {
                          showMessage(context, 'Pls select a network',
                              isError: true);
                          return;
                        }
                        if (_phoneNumber.text.isEmpty ) {
                          showMessage(context, 'Phone number is required',
                              isError: true);
                          return;
                        } if (_phoneNumber.text.length < 11 ) {
                          showMessage(context, 'Enter a valid phone number',
                              isError: true);
                          return;
                        }

                        if ( _amountController.text.isEmpty ) {
                          showMessage(context, 'Amount is required',
                              isError: true);
                          return;
                        }
                        

                        nextScreen(
                            context,
                            AirtimeVerificationScreen(
                              network: _selectedProvider.toString(),
                              phoneNumber: _phoneNumber.text.trim(),
                              amount: _amountController.text,
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
