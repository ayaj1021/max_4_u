import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';

import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/presentation/beneficiary_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_data/data_verification_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class BuyDataScreen extends StatefulWidget {
  const BuyDataScreen({super.key});

  @override
  State<BuyDataScreen> createState() => _BuyDataScreenState();
}

class _BuyDataScreenState extends State<BuyDataScreen> {
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

  @override
  void initState() {
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
    // for (var products in retrievedProducts) {
    //   print('${products.name}: ${products.price}');
      
    // }
  }

  String? selectedLogo;
  String? selectedValidity;
  String? selectedBundle;
  String? selectedBundlePrice;

  final Map<String, String> validityToDuration = {
    'Daily': '1',
    'Weekly': '7',
    'Monthly': '30',
    '3 Months': '90',
    'Yearly': '365',
  };

  List<String> networkProvidersImage = [
    'assets/logo/mtn.png',
    'assets/logo/glo.png',
    'assets/logo/airtel.png',
    'assets/logo/9mobile.png',
  ];

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

  int? selectedLogoIndex;
  int? selectedValidityIndex;
  int? selectedDataPlanIndex;

  final List<String> dataValidityProvider = [
    'Daily',
    'Weekly',
    'Monthly',
    '3 Months',
    'Yearly',
  ];
  //String _selectedDuration = 'Daily';

  void handleBundleSelection(String bundle) {
    setState(() {
      selectedBundle = bundle;
    });
  }

  void handlePriceSelection(String price) {
    setState(() {
      selectedBundlePrice = price;
    });
  }

  void handleLogoSelection(String logo) {
    setState(() {
      selectedLogo = logo;
      selectedValidity = null;
    });
    print('Selected logo: $selectedLogo');
    print(
        'Available logos in products: ${retrievedProducts.map((product) => product.logo).toSet().toList()}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        var logos =
            retrievedProducts.map((product) => product.logo).toSet().toList();

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
                        onTap: () =>
                            nextScreenReplace(context, DashBoardScreen()),
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
                  verticalSpace(44),
                  Text(
                    'Select Network',
                    style: AppTextStyles.font14.copyWith(
                      color: const Color(0xff475569),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        logos.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    handleLogoSelection(
                                        logos[index].toString());
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
                                        radius: 25,
                                        child: Image.asset(
                                            networkProvidersImage[index])),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  verticalSpace(20),
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
                  if (selectedLogo != null)
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
                                    color: selectedValidityIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                                borderRadius: BorderRadius.circular(8),
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
                  verticalSpace(27),
                  if (selectedLogo != null && selectedValidity != null)
                    SizedBox(
                      height: 150,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: retrievedProducts
                            .where((product) =>
                                product.logo == selectedLogo &&
                                product.duration ==
                                    validityToDuration[selectedValidity]!)
                            .length,
                        itemBuilder: (context, index) {
                          var filteredProducts = retrievedProducts
                              .where((product) =>
                                  product.logo == selectedLogo &&
                                  product.duration ==
                                      validityToDuration[selectedValidity]!)
                              .toList();
                          final price = filteredProducts[index].price;
                          return InkWell(
                            onTap: () {
                              print(
                                ' ${filteredProducts[index].code}',
                              );

                              setState(() {
                                selectedDataPlanIndex = index;
                              });
                              handleBundleSelection(
                                  filteredProducts[index].code.toString());
                              handlePriceSelection(price.toString());
                            },
                            child: Container(
                              height: 100.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 3,
                                    color: selectedDataPlanIndex == index
                                        ? AppColors.primaryColor
                                        : Colors.transparent),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      filteredProducts[index].name.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      ' ${filteredProducts[index].code}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  verticalSpace(130),
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
                            network: selectedLogo.toString(),
                            amount: selectedBundlePrice.toString(),
                            phoneNumber: _phoneNumberController.text,
                            dataBundle: selectedBundle.toString(), userType: 'user',
                          ),
                        );
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
