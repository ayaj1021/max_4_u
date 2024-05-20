import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:toastification/toastification.dart';


void showMessage(BuildContext context, String message, {bool isError = false}) {
  toastification.show(
      context: context,
     // backgroundColor: isError == true ? Colors.red : Colors.green,
      title: Text(
        message,
        style: AppTextStyles.font18,
      ),
      showProgressBar: true,
      autoCloseDuration: const Duration(seconds: 3),
      type: isError ? ToastificationType.error : ToastificationType.success,
      //Other parameters
      animationDuration: const Duration(milliseconds: 100),
      animationBuilder: (context, animation, alignment, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      });
}