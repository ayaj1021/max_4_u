import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/airtime_verification_screen.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/widgets/input_phone_number_beneficiary_widget.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/widgets/select_amount_section.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/widgets/select_network_widget.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/provider/buy_airtime_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';

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
    print('Selected logo: $selectedLogo');
    print(
        'Available logos in products: ${retrievedProducts.map((product) => product.logo).toSet().toList()}');
  }

  @override
  void initState() {
    getProduct();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  List<String> networkProvidersImage = [
    'assets/logo/mtn.png',
    'assets/logo/glo.png',
    'assets/logo/airtel.png',
    'assets/logo/9mobile.png',
  ];

  @override
  void dispose() {
    _phoneNumber.dispose();
    _amountController.dispose();

    super.dispose();
  }

  String _selectedNetwork = networkProviders[0];

  getProduct() async {
    final storage = await SecureStorage();

    retrievedProducts = (await storage.getUserProducts())!;
    for (var products in retrievedProducts) {
      print('${products.name}: ${products.price}');
      print('${products.logo}: ${products.duration}');
    }
  }

  int? selectedLogoIndex;

  var codeValues = [];
  var networks = [];
  getProductCodeValues() async {
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
                          'Buy Airtime',
                          style: AppTextStyles.font18,
                        )
                      ],
                    ),
                    verticalSpace(64),
                    SelectNetworkWidget(
                      networkProviders: networkProviders,
                      selectedNetwork: _selectedNetwork,
                    ),
                    verticalSpace(30),
                    InputPhoneNumberAndBeneficiaryWidget(
                        phoneNumber: _phoneNumber),
                    verticalSpace(30),
                    SelectAmountSection(
                      amount: amount,
                      phoneNumber: _phoneNumber,
                      amountController: _amountController,
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
                              network: _selectedNetwork.toString(),
                              //selectedLogo.toString(),
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
