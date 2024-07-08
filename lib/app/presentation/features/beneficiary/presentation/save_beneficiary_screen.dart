import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/beneficiary/presentation/confirm_saved_beneficiary_screen.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/provider/save_beneficiary_provider.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SaveBeneficiaryScreen extends StatefulWidget {
  const SaveBeneficiaryScreen({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<SaveBeneficiaryScreen> createState() => _SaveBeneficiaryScreenState();
}

class _SaveBeneficiaryScreenState extends State<SaveBeneficiaryScreen> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SaveBeneficiaryProvider, ReloadUserDataProvider>(
        builder: (context, saveBen, reloadData, _) {
      return BusyOverlay(
        show: saveBen.state == ViewState.Busy,
        title: saveBen.message,
        child: Scaffold(
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
                       Text(
                        'Save Beneficiary',
                        style: AppTextStyles.font18,
                      )
                    ],
                  ),
                  verticalSpace(64),
                  Text(
                    'Phone number',
                    style: AppTextStyles.font14.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff475569),
                    ),
                  ),
                  verticalSpace(8),
                  Container(
                    height: 52.h,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(left: 16, top: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xffE0E0E0),
                    ),
                    child: Text(
                      widget.phoneNumber,
                      style: AppTextStyles.font14.copyWith(
                        color: Color(0xffAAA3A3),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  verticalSpace(36),
                  TextInputField(
                    controller: _nameController,
                    labelText: 'Set name',
                    hintText: 'Enter beneficiary name',
                  ),
                  verticalSpace(80),
                  ButtonWidget(
                      text: 'Save Beneficiary',
                      onTap: () async {
                        if (_nameController.text.isEmpty) {
                          showMessage(context, 'Beneficiary name is required',
                              isError: true);
                          return;
                        }

                        await saveBen.saveToBeneficiary(
                            phoneNumber: widget.phoneNumber,
                            beneficiaryName: _nameController.text.trim());

                        if (saveBen.status == false && context.mounted) {
                          showMessage(context, saveBen.message);
                          return;
                        }

                        if (saveBen.status == true && context.mounted) {
                          showMessage(context, saveBen.message);
                          await reloadData.reloadUserData();
                          nextScreen(
                              context, const ConfirmSavedBeneficiaryScreen(userType: 'user',));
                        }
                      })
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
