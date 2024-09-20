import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/views/airtime_verification_screen.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';

// ignore: must_be_immutable
class SelectAmountSection extends StatefulWidget {
  SelectAmountSection(
      {super.key,
      required this.amount,
      required this.phoneNumber,
      required this.amountController,
      required this.selectedNetwork});

  final List amount;
  int? selectedIndex;
  String? airtimeAmount;
  final String selectedNetwork;
  final TextEditingController phoneNumber;
  final TextEditingController amountController;
  @override
  State<SelectAmountSection> createState() => _SelectAmountSectionState();
}

class _SelectAmountSectionState extends State<SelectAmountSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: AppTextStyles.font14.copyWith(
            color: const Color(0xff475569),
            fontWeight: FontWeight.w500,
          ),
        ),
        verticalSpace(10),
        SizedBox(
          height: 120.h,
          child: GridView.builder(
              itemCount: widget.amount.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 35,
                childAspectRatio: 2.3,
              ),
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedIndex = index;

                      widget.airtimeAmount =
                          widget.amount[widget.selectedIndex!.toInt()];
                    });

                    if (widget.phoneNumber.text.isEmpty) {
                      return;
                    } else {
                      nextScreen(
                          context,
                          AirtimeVerificationScreen(
                            network: '${widget.selectedNetwork}',
                            phoneNumber: widget.phoneNumber.text.trim(),
                            amount: widget.airtimeAmount.toString(),
                          ));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 42.h,
                    width: 96.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.whiteColor,
                      border: Border.all(
                        color:
                            // selectedIndex == index
                            //     ? AppColors.primaryColor
                            //     :
                            const Color(0xffCBD5E1),
                      ),
                    ),
                    child: Text(
                      'N${widget.amount[index]}',
                      style: AppTextStyles.font14.copyWith(
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }),
        ),
        verticalSpace(14),
        TextInputField(
          controller: widget.amountController,
          hintText: '50-350,000',
          textInputType: TextInputType.number,
          onChanged: (p0) {
            if (widget.airtimeAmount != null) {
              widget.amountController.text = widget.airtimeAmount.toString();
            }
          },
        ),
      ],
    );
  }
}
