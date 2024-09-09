import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/successful_price_set_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/setup_prices_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SetupNewDataPricesScreen extends StatefulWidget {
  const SetupNewDataPricesScreen({super.key});
  static const routeName = '/setPricesScreen';

  @override
  State<SetupNewDataPricesScreen> createState() =>
      _SetupNewDataPricesScreenState();
}

class _SetupNewDataPricesScreenState extends State<SetupNewDataPricesScreen> {
  //String _selectedNetwork = networkProviders[0];

  // String? _selectedDataPrice = dataPrices[0];
  // String _selectedBundle = dataBundles['mtn']![0];

  final _setPriceController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _customerDiscountController = TextEditingController();
  final _vendorDiscountController = TextEditingController();
  final _serviceFeeController = TextEditingController();
  final _logoNameController = TextEditingController();
  final _durationController = TextEditingController();

  final _productNameController = TextEditingController();
  final _productCodeController = TextEditingController();

  List<Product> retrievedProducts = [];
  List<VendingCode> vendingCode = [];

  @override
  initState() {
    getProduct();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  getProduct() async {
    final storage = await SecureStorage();

    retrievedProducts = (await storage.getUserProducts())!;
  }

  String? _selectedServices;
  String? _selectedCategory;
  String? _selectedVendingCode;

  @override
  void dispose() {
    _setPriceController.dispose();
    _productPriceController.dispose();
    _customerDiscountController.dispose();
    _vendorDiscountController.dispose();
    _serviceFeeController.dispose();
    _logoNameController.dispose();
    _durationController.dispose();

    super.dispose();
  }

  //String selectedService = _selectedServices!;

  List<VendingCode> getFilteredVendingCodes(
      String provider, ReloadUserDataProvider reloadData) {
    return reloadData.loadData.vendingCode!
        .where((code) => code.code?.contains(provider) ?? false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SetupPricesProvider, ReloadUserDataProvider>(
      builder: (context, setupPrice, reloadData, _) {
        final serviceNames = retrievedProducts
            .map((product) => product.serviceName)
            .toSet()
            .toList();

        final categories = retrievedProducts
            .map((products) => products.category)
            .toSet()
            .toList();

        // final vendingCode = reloadData.loadData.vendingCode
        //     ?.map((vending) => vending.code)
        //     .toSet()
        //     .toList();

        // final vendingCodes = reloadData.loadData.vendingCode
        //     ?.where((vending) => vending.code == serviceNames)
        //     .toSet()
        //     .toList();

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
                      TextInputField(
                        controller: _productNameController,
                        labelText: 'Product name',
                        hintText: 'product name',
                      ),
                      verticalSpace(27),
                      TextInputField(
                        controller: _productCodeController,
                        labelText: 'Product code',
                        hintText: 'product code',
                      ),
                      verticalSpace(27),
                      Text(
                        'Service name',
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
                          isExpanded: true,
                          elevation: 0,
                          hint: Text('Select a service'),
                          borderRadius: BorderRadius.circular(12),
                          underline: const SizedBox(),
                          value: _selectedServices,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedServices = newValue;
                            });
                          },
                          // retrievedProducts.map((product) => product.serviceName).toSet().toList()}
                          items: serviceNames
                              .map((service) {
                                return DropdownMenuItem<String>(
                                  value: service,
                                  child: Text(
                                    "${service!.toUpperCase()}",
                                    style: AppTextStyles.font14.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              })
                              .toSet()
                              .toList(),
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
                          isExpanded: true,
                          hint: Text('Select a category'),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(12),
                          underline: const SizedBox(),
                          value: _selectedCategory,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                          items: categories
                              .map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 265),
                                    child: Text(
                                      category.toString().toUpperCase(),
                                      style: AppTextStyles.font14.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              })
                              .toSet()
                              .toList(),
                        ),
                      ),
                      verticalSpace(24),
                      TextInputField(
                        controller: _productPriceController,
                        labelText: 'Product price',
                        hintText: 'N50',
                        textInputType: TextInputType.number,
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
                      Text(
                        'Vending code',
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
                          isExpanded: true,
                          elevation: 0,
                          hint: Text('Select vending code'),
                          borderRadius: BorderRadius.circular(12),
                          underline: const SizedBox(),
                          value: _selectedVendingCode,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedVendingCode = newValue;
                            });
                          },
                          // retrievedProducts.map((product) => product.serviceName).toSet().toList()}
                          items: getFilteredVendingCodes(
                                  _selectedServices.toString(), reloadData)
                              .map((vending) {
                                return DropdownMenuItem<String>(
                                  value: vending.code,
                                  child: Text(
                                    "${vending.code!.toUpperCase()}",
                                    style: AppTextStyles.font14.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              })
                              .toSet()
                              .toList(),
                        ),
                      ),
                      verticalSpace(40),
                      ButtonWidget(
                          onTap: () async {
                            if (_setPriceController.text.isEmpty ||
                                _customerDiscountController.text.isEmpty ||
                                _vendorDiscountController.text.isEmpty ||
                                _serviceFeeController.text.isEmpty ||
                                _logoNameController.text.isEmpty ||
                                _durationController.text.isEmpty ||
                                _selectedVendingCode == null) {
                              showMessage(context, 'All fields are required',
                                  isError: true);
                              return;
                            }

                            await setupPrice.setupPrices(
                              productName: _productNameController.text.trim(),
                              productCode: _productCodeController.text.trim(),
                              serviceName: _selectedServices.toString(),
                              category: _selectedCategory.toString(),
                              productPrice: _setPriceController.text.trim(),
                              customerDiscount:
                                  _customerDiscountController.text.trim(),
                              vendorDiscount:
                                  _vendorDiscountController.text.trim(),
                              serviceFee: _serviceFeeController.text.trim(),
                              logoName: _logoNameController.text.trim(),
                              duration: _durationController.text.trim(),
                              vendingCode: _selectedVendingCode.toString(),
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
}
