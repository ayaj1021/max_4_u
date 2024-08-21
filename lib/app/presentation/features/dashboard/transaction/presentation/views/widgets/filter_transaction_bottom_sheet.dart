  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

final categories = [
    'All',
    'Added funds',
    'Data',
    'Airtime',
  ];

  final status = [
    'All',
    'Successful',
    'Pending',
    'Failed',
  ];

int? categoryIndex;
 int? statusIndex;

Future<dynamic> filterTransactionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              height: 600.h,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppColors.whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/icons/cancel_icon.png'),
                    ),
                  ),
                  verticalSpace(9),
                  //Choose category filter section
                  Text(
                    'CATEGORIES',
                    style: AppTextStyles.font12
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  verticalSpace(12),
                  SizedBox(
                    height: 120.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categories[index],
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainTextColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        categoryIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: categoryIndex == index
                                              ? AppColors.primaryColor
                                              : const Color(0xff333333),
                                        ),
                                      ),
                                      child: categoryIndex == index
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: categoryIndex == index
                                                    ? AppColors.primaryColor
                                                    : AppColors.whiteColor,
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff333333),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                            ],
                          );
                        }),
                  ),
                  verticalSpace(10),
                  Image.asset('assets/icons/divider_image.png'),
                  //Choose status user section
                  verticalSpace(10),
                  Text(
                    'STATUS',
                    style: AppTextStyles.font12
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  verticalSpace(12),
                  SizedBox(
                    height: 120.h,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: status.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    status[index],
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainTextColor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        statusIndex = index;
                                      });
                                    },
                                    child: Container(
                                      height: 18,
                                      width: 18,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: statusIndex == index
                                              ? AppColors.primaryColor
                                              : const Color(0xff333333),
                                        ),
                                      ),
                                      child: statusIndex == index
                                          ? Container(
                                              height: 16,
                                              width: 16,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: statusIndex == index
                                                    ? AppColors.primaryColor
                                                    : AppColors.whiteColor,
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff333333),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                            ],
                          );
                        }),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          height: 48.h,
                          width: 169.w,
                          child: ButtonWidget(
                            text: 'Reset',
                            color: AppColors.whiteColor,
                            textColor: AppColors.primaryColor,
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                          )),
                      SizedBox(
                          height: 48.h,
                          width: 169.w,
                          child: const ButtonWidget(
                            text: 'Apply filter',
                          ))
                    ],
                  )
                ],
              ),
            );
          });
        });
  }
