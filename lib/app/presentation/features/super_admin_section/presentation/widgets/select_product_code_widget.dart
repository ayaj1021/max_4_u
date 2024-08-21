import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

// ignore: must_be_immutable
class SelectProductCodeWidget extends StatefulWidget {
  SelectProductCodeWidget(
      {super.key,
      required this.logos,
      required this.handleLogoSelection,
  
      required this.networkProvidersImage});

  final List<String?> logos;
  final void Function(String logo) handleLogoSelection;
 

  final List<String> networkProvidersImage;

  @override
  State<SelectProductCodeWidget> createState() =>
      _SelectProductCodeWidgetState();
}

class _SelectProductCodeWidgetState extends State<SelectProductCodeWidget> {
    int? selectedLogoIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Code',
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
              widget.logos.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                                  : Colors.transparent),
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
        //     // hint: Text('MTN'),

        //     borderRadius: BorderRadius.circular(12),
        //     underline: const SizedBox(),
        //     value: _selectedBundle,
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         _selectedBundle = newValue!;
        //       });
        //     },
        //     items:
        //         dataBundles[_selectedNetwork]!.map((String data) {
        //       return DropdownMenuItem(
        //         value: data,
        //         onTap: () {
        //           // setState(() {
        //           //   network =
        //           //       _networkToString(network) as NetworkProvider;
        //           // });
        //         },
        //         child: Container(
        //           margin: const EdgeInsets.only(right: 155),
        //           child: Container(
        //             margin: const EdgeInsets.only(top: 8),
        //             child: Text(
        //               data.toUpperCase(),
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
      ],
    );
  }
}
