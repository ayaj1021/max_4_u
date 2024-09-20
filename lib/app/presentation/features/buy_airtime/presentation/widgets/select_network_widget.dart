import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

// ignore: must_be_immutable
class SelectNetworkWidget extends StatefulWidget {
  SelectNetworkWidget(
      {super.key, required this.selectedNetwork, required this.network});
  String? selectedNetwork;
  List<String> network;

  @override
  State<SelectNetworkWidget> createState() => _SelectNetworkWidgetState();
}

class _SelectNetworkWidgetState extends State<SelectNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            value: widget.selectedNetwork,
            onChanged: (String? newValue) {
              setState(() {
                widget.selectedNetwork = newValue;
                log("network ${ widget.selectedNetwork}");
              });
            },
            items: widget.network.map((String provider) {
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
     
      ],
    );
  }
}
