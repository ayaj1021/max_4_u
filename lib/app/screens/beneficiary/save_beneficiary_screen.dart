import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/beneficiary/confirm_saved_beneficiary_screen.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class SaveBeneficiaryScreen extends StatefulWidget {
  const SaveBeneficiaryScreen({super.key});

  @override
  State<SaveBeneficiaryScreen> createState() => _SaveBeneficiaryScreenState();
}

class _SaveBeneficiaryScreenState extends State<SaveBeneficiaryScreen> {
  final _phoneNumberController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
          child: Column(
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
                  const Text(
                    'Save Beneficiary',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(64),
              TextInputField(
                controller: _phoneNumberController,
                labelText: 'Phone number',
                hintText: '09012345678',
              ),
              verticalSpace(36),
              TextInputField(
                controller: _nameController,
                labelText: 'Phone number',
                hintText: 'e.g Adedokun Peace',
              ),
              verticalSpace(80),
              ButtonWidget(
                text: 'Save Beneficiary',
                onTap: () =>
                    nextScreen(context, const ConfirmSavedBeneficiaryScreen()),
              )
            ],
          ),
        ),
      )),
    );
  }
}
