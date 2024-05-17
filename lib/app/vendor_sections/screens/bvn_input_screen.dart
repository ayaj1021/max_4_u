import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class BvnNinInputScreen extends StatefulWidget {
  const BvnNinInputScreen({super.key});

  @override
  State<BvnNinInputScreen> createState() => _BvnNinInputScreenState();
}

class _BvnNinInputScreenState extends State<BvnNinInputScreen> {
  final _ninController = TextEditingController();
  final _bvnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
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
            verticalSpace(36),
            TextInputField(
              controller: _bvnController,
              labelText: 'Your BVN',
            ),
            verticalSpace(400),
            ButtonWidget(
              text: 'Submit',
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      )),
    );
  }
}
