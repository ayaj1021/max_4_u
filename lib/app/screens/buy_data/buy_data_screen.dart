import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';

import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/beneficiary/beneficiary_screen.dart';
import 'package:max_4_u/app/screens/buy_data/data_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class BuyDataScreen extends StatefulWidget {
  const BuyDataScreen({super.key});

  @override
  State<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends State<BuyDataScreen> {
  //String _selectedNetwork = networkProvider[0];
// String selectedValidity = dataValidityProvider[0];
  // String _selectedBundle = dataBundles['mtn']![0];

  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  var codeValues = [];
  var networks = [];
  List<Product> retrievedProducts = [];

  List<String> durationMap = [
    'Daily',
    'Weekly',
    'Monthly',
    '3 Months',
    'Yearly',
  ];
  // getNetworks() {
  //   getNetWorkText(network) {
  //     switch (network) {
  //       case 'mtn':
  //         return durationMap[0];
  //       case 'glo':
  //         return durationMap[1];
  //       case 'airtel':
  //         return durationMap[2];
  //       case '9mobile':
  //         return durationMap[3];

  //       default:
  //         return 'No value';
  //     }
  //   }

  //   for (var logo in retrievedProducts) {
  //     getNetWorkText(durationMap[logo.logo]);
  //   }
  // }

  getDuration(selectedNetwork) {
    final durations =
        retrievedProducts.where((products) => products.logo == selectedNetwork);

    getDurationText(durationTime) {
      switch ((durations)) {
        case '1':
          return durationMap[0];
        //"Daily";
        case '7':
          return durationMap[1];
        //"Weekly";
        case '30':
        case '31':
          return durationMap[2];

        //"Monthly";
        case '90':
          return durationMap[3];
        //"3 Months";
        case '365':
          return durationMap[4];

        //"Yearly";
        default:
          return 'no day';
      }
    }

    for (var duration in retrievedProducts) {
      //getDurationText(durationMap[duration.duration]);
      // print('This is duration $duration');
    }
  }

  @override
  void initState() {
    getProduct();
    super.initState();
  }

  getProduct() async {
    final storage = await SecureStorage();

    retrievedProducts = (await storage.getUserProducts())!;
    for (var products in retrievedProducts) {
      print('${products.name}: ${products.price}');
      print('${products.logo}: ${products.duration}');
    }
  }

  //String _selectedDuration = 'Daily';

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        // String _selectedNetwork = reloadData.loadData.products![0].serviceName!;
        // String _selectedValidity = reloadData.loadData.products![0].duration!;
        final products = reloadData.loadData.products!;
        String? _selectedNetwork = networkProviders.join(',');

        //  String? _selectedNetwork = products[0].serviceName;
        String? _selectedDuration = durationMap[0];
        //getDuration().toString();
        String? _selectedBundle = products[0].code;

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
                      Text(
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
                    child: DropdownMenu(
                      hintText: 'Select network',
                      width: 330.w,
                      enableFilter: true,
                      enableSearch: false,
                      inputDecorationTheme: InputDecorationTheme(
                        fillColor: AppColors.whiteColor,
                        border: InputBorder.none,
                      ),
                      onSelected: (newValue) {
                        setState(() {
                          _selectedNetwork = newValue;
                          _selectedBundle = '';
                        });
                      },
                      dropdownMenuEntries: dataValidityProvider
                          .map(( networkProviders) {
                        return DropdownMenuEntry(
                          value: networkProviders,
                          label: networkProviders.toString(),
                        );
                      }).toList(),
                    ),
                  ),
                  verticalSpace(30),
                  Stack(
                    children: [
                      TextInputField(
                        controller: _phoneNumberController,
                        textInputType: TextInputType.number,
                        labelText: 'Phone Number',
                        hintText: 'Receiver\'s number',
                        maxLength: 11,
                      ),
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            var number = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => BeneficiaryScreen()));

                            if (number != null) {
                              _phoneNumberController.text = number;
                            }
                          },
                          //nextScreen(context, const BeneficiaryScreen()),
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
                    child: DropdownMenu(
                      hintText: 'Select data period',
                      width: 330.w,
                      enableFilter: true,
                      enableSearch: false,
                      inputDecorationTheme: InputDecorationTheme(
                        fillColor: AppColors.whiteColor,
                        border: InputBorder.none,
                      ),
                      onSelected: (newValue) {
                        setState(() {
                          _selectedDuration = newValue!;
                        });
                      },
                      dropdownMenuEntries:
                          durationMap.map((String dataValidity) {
                        return DropdownMenuEntry(
                          value: dataValidity,
                          label: dataValidity.toUpperCase(),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        log(_selectedDuration.toString());
                        // log(retrievedProducts[10].duration);
                        //log(getDuration());
                      },
                      child: Text('')),
                  verticalSpace(27),
                  Text(
                    'Data Bundle',
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
                    child: DropdownMenu(
                      hintText: 'Select data bundle',
                      width: 330.w,
                      enableFilter: true,
                      enableSearch: false,
                      inputDecorationTheme: InputDecorationTheme(
                        fillColor: AppColors.whiteColor,
                        border: InputBorder.none,
                      ),
                      onSelected: (newValue) {
                        setState(() {
                          _selectedBundle = newValue!;
                        });
                      },
                      dropdownMenuEntries: dataBundles[_selectedNetwork]!
                          .map((String dataBundleType) {
                        return DropdownMenuEntry(
                          value: dataBundleType,
                          label: dataBundleType.toUpperCase(),
                        );
                      }).toList(),
                    ),
                  ),
                  verticalSpace(169),
                  ButtonWidget(
                      text: 'Continue',
                      onTap: () async {
                        if (_phoneNumberController.text.isEmpty) {
                          showMessage(context, 'Phone number is required',
                              isError: true);
                          return;
                        }
                        nextScreen(
                            context,
                            DataVerificationScreen(
                              network: _selectedNetwork.toString(),
                              amount: _selectedBundle.toString(),
                              phoneNumber: _phoneNumberController.text,
                              dataBundle: _selectedBundle.toString(),
                            ));
                      })
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
