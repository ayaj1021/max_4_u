import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/presentation/beneficiary_screen.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';

class InputPhoneNumberAndBeneficiaryWidget extends StatelessWidget {
  const InputPhoneNumberAndBeneficiaryWidget({
    super.key,
    required TextEditingController phoneNumber,
  }) : _phoneNumber = phoneNumber;

  final TextEditingController _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextInputField(
          controller: _phoneNumber,
          labelText: 'Phone Number',
          hintText: 'Receiver\'s number',
          textInputType: TextInputType.number,
          maxLength: 11,
          onChanged: (p0) {},
        ),
        Positioned(
          right: 0,
          child: GestureDetector(
            onTap: () async {
              var number = await Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          BeneficiaryScreen()));
    
              if (number != null) {
                _phoneNumber.text = number;
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
    );
  }
}
