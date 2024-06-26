import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/buy_data_provider.dart';
import 'package:max_4_u/app/screens/beneficiary/beneficiary_screen.dart';
import 'package:max_4_u/app/screens/buy_data/data_verification_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
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
  String _selectedNetwork = networkProvider[0];
  String selectedValidity = dataValidityProvider[0];
  String _selectedBundle = dataBundle[0];

  final _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  var codeValues = [];
  var networks = [];
  // getProductCodeValues() async {
  //   final code = await SecureStorage().getUserProducts();
  //   final network = code
  //       .where((code) => code['name'] == 'mtn')
  //       .map((code) => code['code'])
  //       .toList();

  //   final productCodes = code
  //       .where((code) => code['category'] == 'airtime')
  //       .map((code) => code['code'])
  //       .toList();

  //   setState(() {
  //     networks = network;
  //     codeValues = productCodes;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<BuyDataProvider>(builder: (context, buyData, _) {
      return BusyOverlay(
        show: buyData.state == ViewState.Busy,
        title: buyData.message,
        child: Scaffold(
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
                          _selectedNetwork = newValue!;
                        });
                      },
                      dropdownMenuEntries:
                          networkProvider.map((String networkProviders) {
                        return DropdownMenuEntry(
                          value: networkProviders,
                          label: networkProviders.toUpperCase(),
                        );
                      }).toList(),
                    ),
                  ),

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
                  //   child: DropdownButton<String>(
                  //     elevation: 0,
                  //     borderRadius: BorderRadius.circular(12),
                  //     underline: const SizedBox(),
                  //     value: _selectedNetwork,
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         _selectedNetwork = newValue!;
                  //       });
                  //     },
                  //     items: networkProvider.map((String networkProviders) {
                  //       return DropdownMenuItem(
                  //         value: networkProviders,
                  //         child: Container(
                  //           margin: const EdgeInsets.only(right: 270),
                  //           child: Container(
                  //             margin: const EdgeInsets.only(top: 8),
                  //             child: Text(
                  //               networkProviders.toUpperCase(),
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
                  //   child: DropdownButton<String>(
                  //     elevation: 0,
                  //     borderRadius: BorderRadius.circular(12),
                  //     underline: const SizedBox(),
                  //     value: _selectedValidity,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         _selectedValidity = newValue!;
                  //       });
                  //     },
                  //     items: dataValidityProvider.map((String dataValidity) {
                  //       return DropdownMenuItem(
                  //         value: dataValidity,
                  //         child: Container(
                  //           margin: const EdgeInsets.only(right: 260),
                  //           child: Container(
                  //             margin: const EdgeInsets.only(top: 8),
                  //             child: Text(
                  //               dataValidity.toUpperCase(),
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
                          selectedValidity = newValue!;
                        });
                      },
                      dropdownMenuEntries:
                          dataValidityProvider.map((String dataValidity) {
                        return DropdownMenuEntry(
                          value: dataValidity,
                          label: dataValidity.toUpperCase(),
                        );
                      }).toList(),
                    ),
                  ),
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
                      dropdownMenuEntries:
                          dataBundle.map((String dataBundleType) {
                        return DropdownMenuEntry(
                          value: dataBundleType,
                          label: dataBundleType.toUpperCase(),
                        );
                      }).toList(),
                    ),
                  ),

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
                  //   child: DropdownButton<String>(
                  //     elevation: 0,
                  //     borderRadius: BorderRadius.circular(12),
                  //     underline: const SizedBox(),
                  //     value: _selectedBundle,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         _selectedBundle = newValue!;
                  //       });
                  //     },
                  //     items: dataBundle.map((String dataBundleType) {
                  //       return DropdownMenuItem(
                  //         value: dataBundleType,
                  //         child: Container(
                  //           margin: const EdgeInsets.only(right: 185),
                  //           child: Container(
                  //             margin: const EdgeInsets.only(top: 8),
                  //             child: Text(
                  //               dataBundleType.toUpperCase(),
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
                              network: _selectedNetwork,
                              amount: _selectedBundle,
                              phoneNumber: _phoneNumberController.text,
                              dataBundle: _selectedBundle,
                            ));
                      })
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
