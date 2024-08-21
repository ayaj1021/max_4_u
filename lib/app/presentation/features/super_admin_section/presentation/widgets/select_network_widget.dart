import 'package:flutter/material.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/model/load_data_model.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectNetworkWidget extends StatefulWidget {
  SelectNetworkWidget(
      {super.key,
      required this.logos,
      required this.handleLogoSelection,
      required this.networkProvidersImage});
  final List<String?> logos;
  final void Function(String logo) handleLogoSelection;

  final List<String> networkProvidersImage;
  @override
  State<SelectNetworkWidget> createState() => _SelectNetworkWidgetState();
}

class _SelectNetworkWidgetState extends State<SelectNetworkWidget> {
  List<Product> retrievedProducts = [];
  int? selectedLogoIndex;

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
    // for (var products in retrievedProducts) {
    //   print('${products.name}: ${products.price}');

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(builder: (context, reloadData, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Select Network',
              style: AppTextStyles.font14.copyWith(
                color: const Color(0xff475569),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          verticalSpace(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                widget.logos.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.handleLogoSelection(
                                widget.logos[index].toString());
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
                                  : Colors.transparent,
                            ),
                            child: CircleAvatar(
                                radius: 25,
                                child: Image.asset(
                                    widget.networkProvidersImage[index])),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
