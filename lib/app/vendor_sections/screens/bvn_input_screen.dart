import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/vendor_sections/screens/become_vendor_screen.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class BvnNinInputScreen extends StatefulWidget {
  const BvnNinInputScreen({super.key});

  @override
  State<BvnNinInputScreen> createState() => _BvnNinInputScreenState();
}

class _BvnNinInputScreenState extends State<BvnNinInputScreen> {
  final _ninController = TextEditingController();
  final _bvnController = TextEditingController();

  @override
  void dispose() {
    _ninController.dispose();
    _bvnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeAVendorProvider>(builder: (context, bvn, _) {
      return BusyOverlay(
        show: bvn.state == ViewState.Busy,
        title: bvn.message,
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      horizontalSpace(99),
                      const Text(
                        'KYC Verification',
                        style: AppTextStyles.font18,
                      )
                    ],
                  ),
                  verticalSpace(32),
                  TextInputField(
                    controller: _ninController,
                    labelText: 'Your NIN',
                  ),
                  bvn.status == false
                      ? Text(
                          bvn.ninMessage,
                          style: AppTextStyles.font12.copyWith(
                            color: Colors.red,
                          ),
                        )
                      : Text(''),
                  verticalSpace(30),
                  TextInputField(
                    controller: _bvnController,
                    labelText: 'Your BVN',
                  ),
                  bvn.status == false
                      ? Text(
                          bvn.bvnMessage,
                          style: AppTextStyles.font12.copyWith(
                            color: Colors.red,
                          ),
                        )
                      : Text(''),
                  verticalSpace(400),
                  ButtonWidget(
                    text: 'Submit',
                    onTap: () async {
                      if (_ninController.text.isEmpty ||
                          _bvnController.text.isEmpty) {
                        showMessage(context, 'All fields are required',
                            isError: true);
                        return;
                      }

                      await bvn.uploadNinBvn(
                        bvn: _bvnController.text.trim(),
                        nin: _ninController.text.trim(),
                      );
                      if (bvn.status == false && context.mounted) {
                        showMessage(
                          context,
                          bvn.message,
                          isError: true,
                        );
                        return;
                      }

                      if (bvn.status == true && context.mounted) {
                        showMessage(
                          context,
                          bvn.message,
                          // isError: true,
                        );
                        nextScreen(context, BecomeVendorScreen());
                        //  Navigator.pop(context);
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
