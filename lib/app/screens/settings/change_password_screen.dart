import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 16),
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
                  horizontalSpace(74),
                  const Text(
                    'Change Password',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(25),
              TextInputField(
                controller: _oldPasswordController,
                labelText: 'Old password',
                suffixIcon: Icons.visibility_outlined,
              ),
              TextInputField(
                controller: _newPasswordController,
                labelText: 'New password',
                suffixIcon: Icons.visibility_outlined,
              ),
              TextInputField(
                controller: _confirmNewPasswordController,
                labelText: 'Confirm new password',
                suffixIcon: Icons.visibility_outlined,
              ),
              verticalSpace(34),
              ButtonWidget(
                text: 'Change password',
                onTap: () {},
              )
            ],
          ),
        ),
      )),
    );
  }
}
