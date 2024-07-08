import 'package:flutter/material.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/auth/presentation/change_password_screen.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/back_arrow_button.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ResetCodeScreen extends StatefulWidget {
  const ResetCodeScreen({super.key});

  @override
  State<ResetCodeScreen> createState() => _ResetCodeScreenState();
}

class _ResetCodeScreenState extends State<ResetCodeScreen> {
  final _otpController = TextEditingController();
  // int _minutes = 00;
  // int _seconds = 30;
  // Timer? _timer;
  // bool _isComplete = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _startTimer();
  // }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }

  // void _startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       setState(() {
  //         if (_seconds == 0) {
  //           if (_minutes == 0) {
  //             _timer?.cancel();
  //             _isComplete = true;
  //           } else {
  //             _minutes -= 1;
  //             _seconds = 59;
  //           }
  //         } else {
  //           _seconds -= 1;
  //         }
  //       });
  //     },
  //   );
  // }

  // String _formatTime(int time) {
  //   return time < 10 ? '0$time' : '$time';
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProviderImpl>(builder: (context, authProv, _) {
      return BusyOverlay(
        show: authProv.state == ViewState.Busy,
        title: authProv.message,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackArrowButton(
                      onTap: () => Navigator.pop(context),
                    ),
                    verticalSpace(26),
                     Text(
                      'Reset Code',
                      style: AppTextStyles.font20,
                    ),
                    verticalSpace(12),
                    Text(
                      'Enter the 6-digit code sent to you at “${authProv.email}”',
                      style: AppTextStyles.font14
                          .copyWith(color: const Color(0xff475569)),
                    ),
                    verticalSpace(24),
                    PinCodeTextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      appContext: context,
                      length: 6,
                      pinTheme: PinTheme(
                        inactiveColor: AppColors.borderColor,
                        fieldHeight: 48,
                        fieldWidth: 48,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    verticalSpace(40),
                    ButtonWidget(
                      text: 'Enter',
                      onTap: () async {
                        if (_otpController.text.isEmpty) {
                          showMessage(context, 'Otp fields are required',
                              isError: true);
                          return;
                        }

                        await authProv.verifyForgotPasswordOtp(otp: _otpController.text.trim());
                        if (authProv.state == ViewState.Error &&
                            context.mounted) {
                          showMessage(context, authProv.message);
                          return;
                        }

                        if (authProv.state == ViewState.Success &&
                            context.mounted) {
                          showMessage(context, authProv.message);

                          nextScreen(context, const ChangePassword());
                        }
                      },
                    ),
                    verticalSpace(24),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Didn't get a code?",
                    //       style: AppTextStyles.font14,
                    //     ),
                    //     horizontalSpace(10),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         authProv.forgotPassword();
                    //       },
                    //       child: Text(
                    //         _isComplete
                    //             ? 'Resend Code'
                    //             : '$_minutes:${_formatTime(_seconds)}',
                    //         style: AppTextStyles.font14
                    //             .copyWith(color: AppColors.secondaryColor),
                    //       ),
                    //     ),

                         
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
