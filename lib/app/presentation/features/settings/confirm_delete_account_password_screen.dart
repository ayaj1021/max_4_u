import 'package:flutter/material.dart';
import 'package:max_4_u/app/presentation/features/onboarding/onboard_screen.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:max_4_u/app/provider/delete_account_provider.dart';
import 'package:max_4_u/app/provider/obscure_text_provider.dart';

import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class ConfirmDeleteAccountPasswordScreen extends StatefulWidget {
  const ConfirmDeleteAccountPasswordScreen({super.key});

  @override
  State<ConfirmDeleteAccountPasswordScreen> createState() =>
      _ConfirmDeleteAccountPasswordScreenState();
}

class _ConfirmDeleteAccountPasswordScreenState
    extends State<ConfirmDeleteAccountPasswordScreen> {
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<ObscureTextProvider, DeleteAccountProvider>(
        builder: (context, obscure, deleteAcct, _) {
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                verticalSpace(17),
                Text(
                  'Kindly enter password to delete account',
                  style: AppTextStyles.font14,
                ),
                verticalSpace(17),
                TextInputField(
                  obscure: obscure.isObscure,
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: obscure.isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  onTap: () {
                    obscure.changeObscure();
                  },
                ),
                verticalSpace(400),
                ButtonWidget(
                  text: 'Confirm Delete Account',
                  // color: Colors.red,
                  onTap: () async {
                    await deleteAcct.deleteAccount();
                    if (deleteAcct.status == false && context.mounted) {
                      showMessage(context, deleteAcct.message, isError: true);
                      return;
                    }

                    if (deleteAcct.status == true && context.mounted) {
                      showMessage(context, deleteAcct.message);

                      nextScreenReplace(context, const OnboardScreen());
                    }
                  },
                )
              ],
            ),
          ),
        )),
      );
    });
  }
}
