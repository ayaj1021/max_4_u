import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/presentation/widgets/select_network_widget.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/presentation/widgets/select_product_code_widget.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/successful_price_set_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/setup_prices_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/helper.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SetupNewDataPricesScreen extends StatefulWidget {
  const SetupNewDataPricesScreen({super.key});

  @override
  State<SetupNewDataPricesScreen> createState() =>
      _SetupNewDataPricesScreenState();
}

class _SetupNewDataPricesScreenState extends State<SetupNewDataPricesScreen> {
  //String _selectedNetwork = networkProviders[0];

  String _selectedServices = services[0];
  // String? _selectedDataPrice = dataPrices[0];
  // String _selectedBundle = dataBundles['mtn']![0];

  final _setPriceController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _customerDiscountController = TextEditingController();
  final _vendorDiscountController = TextEditingController();
  final _serviceFeeController = TextEditingController();
  final _logoNameController = TextEditingController();
  final _durationController = TextEditingController();
  final _vendingCodeController = TextEditingController();

  String? _selectedNetwork;
  String? selectedValidity;
  int? selectedLogoIndex;
  String? selectedBundle;
  String? selectedLogo;

  int? selectedDataPlanIndex;
  String? selectedBundlePrice;
  int? selectedValidityIndex;

  @override
  initState() {
    getProduct();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  final Map<String, String> validityToDuration = {
    'Daily': '1',
    'Weekly': '7',
    'Monthly': '30',
    '3 Months': '90',
    'Yearly': '365',
  };

  void handlePriceSelection(String price) {
    setState(() {
      selectedBundlePrice = price;
    });
  }

  List<String> networkProvidersImage = [
    'assets/logo/mtn.png',
    'assets/logo/glo.png',
    'assets/logo/airtel.png',
    'assets/logo/9mobile.png',
  ];

  List<Product> retrievedProducts = [];

  void handleBundleSelection(String bundle) {
    setState(() {
      selectedBundle = bundle;
    });
  }

  void handleLogoSelection(String logo) {
    setState(() {
      _selectedNetwork = logo;
      selectedValidity = null;
    });
    print('Selected logo: $_selectedNetwork');
    print(
        'Available logos in products: ${retrievedProducts.map((product) => product.logo).toSet().toList()}');
  }

  getProduct() async {
    final storage = await SecureStorage();

    retrievedProducts = (await storage.getUserProducts())!;
    // for (var products in retrievedProducts) {
    //   print('${products.name}: ${products.price}');

    // }
  }

  void handleValiditySelection(String validity) {
    setState(() {
      selectedValidity = validity;
    });

    String duration = validityToDuration[validity]!;

    var filteredProducts = retrievedProducts
        .where((product) =>
            product.duration == duration && product.logo == selectedLogo)
        .toList();
    for (var product in filteredProducts) {
      print(
          'Selected Product: ${product.name}, Duration: ${product.duration}, Code: ${product.code}');
    }
  }

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
        var logos =
            retrievedProducts.map((product) => product.logo).toSet().toList();
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
                      SelectNetworkWidget(
                        logos: logos,
                        handleLogoSelection: handleLogoSelection,
                        selectedLogoIndex: selectedLogoIndex,
                        networkProvidersImage: networkProvidersImage,
                      ),
                      verticalSpace(27),
                      SelectProductCodeWidget(
                        logos: logos,
                        handleLogoSelection: handleLogoSelection,
                        selectedLogoIndex: selectedLogoIndex,
                        networkProvidersImage: networkProvidersImage,
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
                                Container(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: dataValidityProvider.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          handleValiditySelection(
                                              dataValidityProvider[index]);
                                          setState(() {
                                            selectedValidityIndex = index;
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 80,
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColors.whiteColor,
                                            border: Border.all(
                                                width: 2,
                                                color: selectedValidityIndex ==
                                                        index
                                                    ? AppColors.primaryColor
                                                    : Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              dataValidityProvider[index],
                                              style: AppTextStyles.font14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                Text(
                                  'Data Bundle',
                                  style: AppTextStyles.font14.copyWith(
                                    color: const Color(0xff475569),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                verticalSpace(8),

                                if (_selectedNetwork != null &&
                                    selectedValidity != null)
                                  SizedBox(
                                    height: 150,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: retrievedProducts
                                          .where((product) =>
                                              product.logo ==
                                                  _selectedNetwork &&
                                              product.duration ==
                                                  validityToDuration[
                                                      selectedValidity]!)
                                          .length,
                                      itemBuilder: (context, index) {
                                        var filteredProducts = retrievedProducts
                                            .where((product) =>
                                                product.logo ==
                                                    _selectedNetwork &&
                                                product.duration ==
                                                    validityToDuration[
                                                        selectedValidity]!)
                                            .toList();
                                        final price =
                                            filteredProducts[index].price;
                                        return InkWell(
                                          onTap: () {
                                            print(
                                              ' ${filteredProducts[index].code}',
                                            );

                                            setState(() {
                                              selectedDataPlanIndex = index;
                                            });
                                            handleBundleSelection(
                                                filteredProducts[index]
                                                    .code
                                                    .toString());
                                            handlePriceSelection(
                                                price.toString());
                                          },
                                          child: Container(
                                            height: 100.h,
                                            width: 100.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 3,
                                                  color:
                                                      selectedDataPlanIndex ==
                                                              index
                                                          ? AppColors
                                                              .primaryColor
                                                          : Colors.transparent),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    filteredProducts[index]
                                                        .name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    ' ${filteredProducts[index].code}',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                // Container(
                                //   // padding: const EdgeInsets.symmetric(horizontal: 15),
                                //   height: 52.h,
                                //   width: 110.w,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(12),
                                //     color: AppColors.whiteColor,
                                //     border: Border.all(
                                //       color: const Color(0xffCBD5E1),
                                //     ),
                                //   ),
                                //   child: DropdownButton<String>(
                                //     // hint: Text('MTN'),
                                //     elevation: 0,
                                //     borderRadius: BorderRadius.circular(12),
                                //     underline: const SizedBox(),
                                //     value: _selectedDataPrice,
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         _selectedDataPrice = newValue!;
                                //       });
                                //     },
                                //     items: dataPrices.map((String dataPrice) {
                                //       return DropdownMenuItem(
                                //         value: dataPrice,
                                //         onTap: () {
                                //           // setState(() {
                                //           //   network =
                                //           //       _networkToString(network) as NetworkProvider;
                                //           // });
                                //         },
                                //         child: Container(
                                //           //margin: const EdgeInsets.only(right: 250),
                                //           child: Container(
                                //             margin: const EdgeInsets.only(
                                //                 top: 8, left: 5),
                                //             child: Text(
                                //               dataPrice,
                                //               style:
                                //                   AppTextStyles.font14.copyWith(
                                //                 fontSize: 14,
                                //                 fontWeight: FontWeight.w400,
                                //                 color: Color(0xffBDBDBD),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //       );
                                //     }).toList(),
                                //   ),
                                // ),
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
                      ButtonWidget(
                          onTap: () async {
                            if (_vendingCodeController.text.isEmpty) {
                              showMessage(
                                  context, 'Vending code cannot be empty',
                                  isError: true);
                              return;
                            }

                            final dataProductCodes = await ProductHelper()
                                .getDataProducts(_selectedNetwork!);
                            print(
                                'This is the code ${dataProductCodes.toString()}');
                            final airtimeProductCodes = await ProductHelper()
                                .getAirtimeProducts(_selectedNetwork!);
                            print(
                                'This is the code ${dataProductCodes.toString()}');

                            await setupPrice.setupPrices(
                              category: _selectedServices,
                              productPrice: _setPriceController.text.trim(),
                              serviceName: _selectedNetwork!,
                              logoName: _logoNameController.text.trim(),
                              productName: _selectedNetwork!,
                              productCode: _selectedServices == services[0]
                                  ? airtimeProductCodes
                                  : dataProductCodes,
                              customerDiscount:
                                  _customerDiscountController.text.trim(),
                              vendorDiscount:
                                  _vendorDiscountController.text.trim(),
                              serviceFee: _serviceFeeController.text.trim(),
                              duration: _durationController.text.trim(),
                              vendingCode: _vendingCodeController.text.trim(),
                            );

                            if (setupPrice.status == false && context.mounted) {
                              showMessage(context, setupPrice.message,
                                  isError: true);

                              return;
                            }

                            if (setupPrice.status == true && context.mounted) {
                              showMessage(context, setupPrice.message,
                                  isError: true);
                              nextScreen(context, SuccessfulPriceSetScreen());
                            }
                          },
                          text: 'Set Price'),
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

  Widget _logoItem(String logo, int index, List<String> logos) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              handleLogoSelection(logos[index].toString());
              setState(() {
                selectedLogoIndex = index;
              });
            },
            child: Container(
              height: 60,
              width: 60,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedLogoIndex == index
                      ? AppColors.primaryColor
                      : Colors.transparent),
              child: CircleAvatar(
                  radius: 25, child: Image.asset(networkProvidersImage[index])),
            ),
          ),
        ],
      ),
    );
  }
}
