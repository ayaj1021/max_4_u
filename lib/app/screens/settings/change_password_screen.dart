import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/change_password_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

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
    return Consumer2<ChangePasswordProvider, ReloadUserDataProvider>(
        builder: (context, changePassword, reloadData, _) {
      return BusyOverlay(
        show: changePassword.state == ViewState.Busy,
        title: changePassword.message,
        child: Scaffold(
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
                       Text(
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
                  verticalSpace(20),
                  TextInputField(
                    controller: _newPasswordController,
                    labelText: 'New password',
                    suffixIcon: Icons.visibility_outlined,
                  ),
                  verticalSpace(20),
                  TextInputField(
                    controller: _confirmNewPasswordController,
                    labelText: 'Confirm new password',
                    suffixIcon: Icons.visibility_outlined,
                  ),
              
                  verticalSpace(34),
                  ButtonWidget(
                    text: 'Change password',
                    onTap: () async {
                      if (_oldPasswordController.text.isEmpty ||
                          _newPasswordController.text.isEmpty ||
                          _confirmNewPasswordController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      await changePassword.changePassword(
                        oldPassword: _oldPasswordController.text.trim(),
                        newPassword: _newPasswordController.text.trim(),
                        confirmNewPassword:
                            _confirmNewPasswordController.text.trim(),
                      );

                      if (changePassword.status == false && context.mounted) {
                        showMessage(
                          context,
                          changePassword.message,
                          isError: true,
                        );
                        return;
                      }

                      if (changePassword.status == true && context.mounted) {
                        showMessage(
                          context,
                          changePassword.message,
                           isError: false,
                        );

                        await reloadData.reloadUserData();

                        nextScreen(context, DashBoardScreen());
                      }
                    },
                  )
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
