import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';

import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class ConfirmSavedBeneficiaryScreen extends StatefulWidget {
  const ConfirmSavedBeneficiaryScreen({super.key});

  @override
  State<ConfirmSavedBeneficiaryScreen> createState() => _ConfirmSavedBeneficiaryScreenState();
}

class _ConfirmSavedBeneficiaryScreenState extends State<ConfirmSavedBeneficiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        return BusyOverlay(
          show: reloadData.state == ViewState.Busy,
          child: Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 67.h,
                    width: 67.w,
                    child: Image.asset('assets/icons/verify_icon.png'),
                  ),
                  verticalSpace(20),
                  Text(
                    'Beneficiary Saved Successfully',
                    style: AppTextStyles.font16.copyWith(
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(56),
                  ButtonWidget(
                    text: 'Continue',
                    onTap: () async {
                      await reloadData.reloadUserData();

                      nextScreen(context, DashBoardScreen());
                    },
                  )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
