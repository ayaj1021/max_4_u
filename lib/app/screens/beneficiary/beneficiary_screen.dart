import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class BeneficiaryScreen extends StatefulWidget {
  const BeneficiaryScreen({super.key});

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProviderImpl>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderImpl>(
      builder: (context, authProv, _) {
        return BusyOverlay(
          show: authProv.state == ViewState.Busy,
          title: 'loading',
          child: Scaffold(
            body: SafeArea(
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
                        'Beneficiary List',
                        style: AppTextStyles.font18,
                      ),
                    ],
                  ),
                  verticalSpace(authProv.beneficiary.isEmpty ? 250 : 38),
                  authProv.beneficiary.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 92.h,
                                  width: 92.w,
                                  child: Image.asset(
                                      'assets/images/no_beneficiary_image.png')),
                              verticalSpace(24),
                              Text(
                                'You have no saved beneficiary',
                                style: AppTextStyles.font14.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: authProv.beneficiary.length,
                              itemBuilder: (_, index) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Peace Adedokun',
                                        style: AppTextStyles.font14.copyWith(
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      verticalSpace(4),
                                      const Text(
                                        '93395853348',
                                        style: AppTextStyles.font18,
                                      ),
                                      verticalSpace(16)
                                    ],
                                  ),
                                );
                              }),
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
