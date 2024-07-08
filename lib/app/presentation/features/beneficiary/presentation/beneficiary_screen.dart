import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
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
      Provider.of<ReloadUserDataProvider>(context, listen: false)
          .reloadUserData();
    });
    super.initState();
  }

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReloadUserDataProvider>(
      builder: (context, reloadData, _) {
        return Scaffold(
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
                    Text(
                      'Beneficiary List',
                      style: AppTextStyles.font18,
                    ),
                  ],
                ),
                verticalSpace(
                    reloadData.loadData.beneficiaryData!.isEmpty ? 250 : 38),
                reloadData.loadData.beneficiaryData!.isEmpty
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
                        child:  Column(
                            children: List.generate(
                                reloadData.loadData.beneficiaryData!.length,
                                (index) {
                              final data =
                                  reloadData.loadData.beneficiaryData![index];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                               
                                  Navigator.of(context).pop('${data.phone}');
                                  //  Navigator.pop(context, index);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${data.name}',
                                      style: AppTextStyles.font14.copyWith(),
                                    ),
                                    verticalSpace(4),
                                    Text(
                                      '${data.phone}',
                                      style: AppTextStyles.font18,
                                    ),
                                    verticalSpace(16),
                                    Divider(
                                        color: AppColors.blackColor
                                            .withOpacity(0.05))
                                  ],
                                ),
                              );
                            }),
                     
                      )),
              ],
            ),
          )),
        );
      },
    );
  }
}
