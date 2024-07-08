import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';

void displayPaymentTransactionStatus(BuildContext context, message) {
  Platform.isIOS
      ? showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 390.w,
                height: 250.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.cancel))),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/verify_image.png',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        message,
                        style: AppTextStyles.font20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      : showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 390.w,
                height: 300.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              nextScreen(context, DashBoardScreen());
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: AppColors.primaryColor,
                            ))),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/verify_image.png',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          message,
                          style: AppTextStyles.font16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
