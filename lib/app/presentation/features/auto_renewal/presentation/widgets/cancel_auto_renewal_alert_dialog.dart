import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class CancelAutoRenewalAlertDialog extends StatelessWidget {
  const CancelAutoRenewalAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cancelAutoRenewalAlertBox(context, (){});
      },
      child: Container(
        height: 54.h,
        width: 193.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'Cancel all auto renewals',
          style: AppTextStyles.font14.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.subTextColor,
          ),
        ),
      ),
    );
  }

}

  Future<dynamic> cancelAutoRenewalAlertBox(BuildContext context,void Function()? onTap) {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 197.h,
                  width: 356.w,
                  // MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      vertical: 17, horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Column(children: [
                    Text(
                      'Cancel Auto Renewal',
                      style:
                          AppTextStyles.font18.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.subTextColor,
                      ),
                    ),
                    verticalSpace(15),
                    Text(
                      'Are you sure you want to cancel auto renewal?',
                      style:
                          AppTextStyles.font14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(25),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        SizedBox(
                          height: 44.h,
                          width: 117.w,
                          child: ButtonWidget(
                            text: 'Yes, proceed',
                            color:
                                const Color(0xff219653),
                            onTap: onTap,
                            
                            //() {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return AlertDialog(
                              //       contentPadding:
                              //           EdgeInsets.zero,
                              //       content: Container(
                              //         padding:
                              //             const EdgeInsets
                              //                 .symmetric(
                              //                 vertical:
                              //                     17,
                              //                 horizontal:
                              //                     23),
                              //         height: 207.h,
                              //         width:
                              //             MediaQuery.of(
                              //                     context)
                              //                 .size
                              //                 .width,
                              //         decoration:
                              //             BoxDecoration(
                              //           color: AppColors
                              //               .whiteColor,
                              //           borderRadius:
                              //               BorderRadius
                              //                   .circular(
                              //                       18),
                              //         ),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment
                              //                   .center,
                              //           children: [
                              //             SizedBox(
                              //               height:
                              //                   67.h,
                              //               width: 67.w,
                              //               child: Image
                              //                   .asset(
                              //                       'assets/icons/verify_icon.png'),
                              //             ),
                              //             verticalSpace(
                              //                 10),
                              //             Text(
                              //               'Canceled Successfully',
                              //               style: AppTextStyles
                              //                   .font16
                              //                   .copyWith(
                              //                 color: AppColors
                              //                     .mainTextColor,
                              //                 fontWeight:
                              //                     FontWeight
                              //                         .w600,
                              //               ),
                              //             ),
                              //             verticalSpace(
                              //                 13),
                              //             Text(
                              //               'Auto renewal has been canceled successfully.',
                              //               style: AppTextStyles
                              //                   .font14
                              //                   .copyWith(
                              //                 color: AppColors
                              //                     .textColor,
                              //                 fontWeight:
                              //                     FontWeight
                              //                         .w400,
                              //               ),
                              //               textAlign:
                              //                   TextAlign
                              //                       .center,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                           // },
                          ),
                        ),
                        SizedBox(
                          height: 44.h,
                          width: 117.w,
                          child: ButtonWidget(
                            text: 'No, cancel',
                            color:
                                const Color(0xffF2C94C),
                            onTap: () =>
                                Navigator.pop(context),
                          ),
                        )
                      ],
                    )
                  ]),
                ));
          });
  }

