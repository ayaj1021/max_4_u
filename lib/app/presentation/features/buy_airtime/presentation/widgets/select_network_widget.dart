import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class SelectNetworkWidget extends StatefulWidget {
  SelectNetworkWidget({super.key, required this.selectedNetwork, required this.networkProviders});
 late String selectedNetwork;
  List<String> networkProviders;

  @override
  State<SelectNetworkWidget> createState() => _SelectNetworkWidgetState();
}

class _SelectNetworkWidgetState extends State<SelectNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select Network',
          style: AppTextStyles.font14.copyWith(
            color: const Color(0xff475569),
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(8),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: List.generate(
        //       logos.length,
        //       (index) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(
        //             children: [
        //               InkWell(
        //                 onTap: () {
        //                   handleLogoSelection(
        //                       logos[index].toString());
        //                   setState(() {
        //                     selectedLogoIndex = index;
        //                   });
        //                 },
        //                 child: Container(
        //                   height: 60,
        //                   width: 60,
        //                   padding: EdgeInsets.all(3),
        //                   decoration: BoxDecoration(
        //                       shape: BoxShape.circle,
        //                       color: selectedLogoIndex == index
        //                           ? AppColors.primaryColor
        //                           : Colors.transparent),
        //                   child: CircleAvatar(
        //                       radius: 25,
        //                       child: Image.asset(
        //                           networkProvidersImage[index])),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),

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
          child: DropdownMenu(
            hintText: 'Select network',
            width: 330.w,
            inputDecorationTheme: InputDecorationTheme(
              fillColor: AppColors.whiteColor,
              border: InputBorder.none,
            ),
            onSelected: (newValue) {
              setState(() {
                widget.selectedNetwork = newValue!;
              });
            },
            dropdownMenuEntries:
                widget.networkProviders.map((String networkProviders) {
              return DropdownMenuEntry(
                value: networkProviders,
                label: networkProviders.toUpperCase(),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
