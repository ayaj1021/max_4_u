import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final deleteAccountReasons = [
    'I’ve not had a good app experience',
    'I want to start afresh',
    'Just wanted to check the app out',
    'Others',
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                  horizontalSpace(87),
                  const Text(
                    'Delete Account',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(25),
              Text(
                'Let us know the reason you are leaving',
                style: AppTextStyles.font14.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.mainTextColor,
                ),
              ),
              verticalSpace(18),
              SizedBox(
                height: 170.h,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: deleteAccountReasons.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                deleteAccountReasons[index],
                                style: AppTextStyles.font14.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.mainTextColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 18,
                                  width: 18,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedIndex == index
                                          ? AppColors.primaryColor
                                          : const Color(0xff333333),
                                    ),
                                  ),
                                  child: selectedIndex == index
                                      ? Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: selectedIndex == index
                                                ? AppColors.primaryColor
                                                : AppColors.whiteColor,
                                            border: Border.all(
                                              color: const Color(0xff333333),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(24),
                          selectedIndex == index -1
                              ? Column(
                                  children: [
                                    Text(
                                      'Tell us more about your reason (optional)',
                                      style: AppTextStyles.font14.copyWith(
                                          color: const Color(0xff475569)),
                                    ),
                                  ],
                                )
                              : const SizedBox()
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      )),
    );
  }
}
