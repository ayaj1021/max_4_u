import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/super_admin/setup_prices_provider.dart';
import 'package:max_4_u/app/screens/super_admin_section/successful_price_set_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/helper.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SetupNewDataPricesScreen extends StatefulWidget {
  const SetupNewDataPricesScreen({super.key});

  @override
  State<SetupNewDataPricesScreen> createState() =>
      _SetupNewDataPricesScreenState();
}

class _SetupNewDataPricesScreenState extends State<SetupNewDataPricesScreen> {
  String? _selectedNetwork = networkProvider[0];

  String? _selectedServices = services[0];
  String? _selectedDataPrice = dataPrices[0];
  String _selectedBundle = dataBundles['mtn']![0];

  final _setPriceController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _customerDiscountController = TextEditingController();
  final _vendorDiscountController = TextEditingController();
  final _serviceFeeController = TextEditingController();
  final _logoNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _vendingCodeController = TextEditingController();
  @override
  void dispose() {
    _setPriceController.dispose();
    _productPriceController.dispose();
    _customerDiscountController.dispose();
    _vendorDiscountController.dispose();
    _serviceFeeController.dispose();
    _logoNameController.dispose();
    _durationController.dispose();
    _vendingCodeController.dispose();
    super.dispose();
  }

  //String selectedService = _selectedServices!;
  @override
  Widget build(BuildContext context) {
    return Consumer<SetupPricesProvider>(
      builder: (context, setupPrice, _) {
        return BusyOverlay(
          show: setupPrice.state == ViewState.Busy,
          title: setupPrice.message,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Setup Prices',
                          style: AppTextStyles.font18.copyWith(
                            color: AppColors.mainTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                              onTap: () {
                                // setState(() {
                                //   network =
                                //       _networkToString(network) as NetworkProvider;
                                // });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 255),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    networkProviders.toUpperCase(),
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
                      verticalSpace(27),
                      Text(
                        'Product Code',
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
                          borderRadius: BorderRadius.circular(12),
                          underline: const SizedBox(),
                          value: _selectedBundle,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedBundle = newValue!;
                            });
                          },
                          items:
                              dataBundles[_selectedNetwork]!.map((String data) {
                            return DropdownMenuItem(
                              value: data,
                              onTap: () {
                                // setState(() {
                                //   network =
                                //       _networkToString(network) as NetworkProvider;
                                // });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 155),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    data.toUpperCase(),
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
                      verticalSpace(27),
                      Text(
                        'Category',
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
                          value: _selectedServices,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedServices = newValue!;
                            });
                          },
                          items: services.map((String service) {
                            return DropdownMenuItem(
                              value: service,
                              onTap: () {
                                // setState(() {
                                //   network =
                                //       _networkToString(network) as NetworkProvider;
                                // });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 265),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    service,
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
                      verticalSpace(24),
                      _selectedServices == services[0]
                          ? TextInputField(
                              controller: _productPriceController,
                              labelText: 'Airtime Rate',
                              hintText: 'N50',
                              textInputType: TextInputType.number,
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data Bundle',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff475569),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                verticalSpace(8),
                                Container(
                                  // padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: 52.h,
                                  width: 110.w,
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
                                    borderRadius: BorderRadius.circular(12),
                                    underline: const SizedBox(),
                                    value: _selectedDataPrice,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedDataPrice = newValue!;
                                      });
                                    },
                                    items: dataPrices.map((String dataPrice) {
                                      return DropdownMenuItem(
                                        value: dataPrice,
                                        onTap: () {
                                          // setState(() {
                                          //   network =
                                          //       _networkToString(network) as NetworkProvider;
                                          // });
                                        },
                                        child: Container(
                                          //margin: const EdgeInsets.only(right: 250),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 5),
                                            child: Text(
                                              dataPrice,
                                              style:
                                                  AppTextStyles.font14.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffBDBDBD),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _setPriceController,
                        labelText: 'Set Prices',
                        hintText: 'N2000',
                        textInputType: TextInputType.number,
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _customerDiscountController,
                        labelText: 'Customer Discount',
                        hintText: '0',
                        textInputType: TextInputType.number,
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _vendorDiscountController,
                        labelText: 'Vendor Discount',
                        hintText: '0.5',
                        textInputType: TextInputType.number,
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _serviceFeeController,
                        labelText: 'Service fee',
                        hintText: '0',
                        textInputType: TextInputType.number,
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _logoNameController,
                        labelText: 'Logo name',
                        hintText: 'Glo',
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _durationController,
                        labelText: 'Duration',
                        hintText: '0',
                        textInputType: TextInputType.number,
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _vendingCodeController,
                        labelText: 'Vending code',
                        hintText: 'not yet',
                      ),
                      verticalSpace(40),
                      // ButtonWidget(
                      //     onTap: () async {
                      //       final productCodes = await ProductHelper()
                      //           .getDataProducts(_selectedNetwork!);
                      //       log('This is the code ${productCodes.toString()}');
                      //       // if (_setPriceController.text.isEmpty) {
                      //       //   showMessage(context, 'Price is required');
                      //       //   return;
                      //       //  }

                      //       await setupPrice.setupPrices(
                      //         category: _selectedServices!,
                      //         productPrice: _setPriceController.text.trim(),
                      //         serviceName: _selectedNetwork!,
                      //         logoName: _logoNameController.text.trim(),
                      //         productName: _selectedNetwork!,
                      //         productCode: productCodes,
                      //         customerDiscount:
                      //             _customerDiscountController.text.trim(),
                      //         vendorDiscount:
                      //             _vendorDiscountController.text.trim(),
                      //         serviceFee: _serviceFeeController.text.trim(),
                      //         duration: _durationController.text.trim(),
                      //         vendingCode: _vendingCodeController.text.trim(),
                      //       );

                      //       if (setupPrice.status == false && context.mounted) {
                      //         showMessage(context, setupPrice.message,
                      //             isError: true);

                      //         return;
                      //       }

                      //       if (setupPrice.status == true && context.mounted) {
                      //         showMessage(context, setupPrice.message,
                      //             isError: true);
                      //         nextScreen(context, SuccessfulPriceSetScreen());
                      //       }
                      //     },
                      //     text: 'Set Price'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
