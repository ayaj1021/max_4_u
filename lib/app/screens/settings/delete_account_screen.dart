import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/delete_account_provider.dart';
import 'package:max_4_u/app/screens/auth/sign_up_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

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
    //'Others',
  ];

  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<DeleteAccountProvider>(
      builder: (context, deleteAcct, _) {
        return BusyOverlay(
          show: deleteAcct.state == ViewState.Busy,
          title: deleteAcct.message,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                           Text(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                    color: selectedIndex ==
                                                            index
                                                        ? AppColors.primaryColor
                                                        : AppColors.whiteColor,
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xff333333),
                                                    ),
                                                  ),
                                                )
                                              : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpace(24),
                                  // selectedIndex == index
                                  //     ? Column(
                                  //         children: [
                                  //           Text(
                                  //             'Tell us more about your reason (optional)',
                                  //             style: AppTextStyles.font14.copyWith(
                                  //                 color: const Color(0xff475569)),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     : const SizedBox()
                                ],
                              );
                            }),
                      ),
                      verticalSpace(440),
                      ButtonWidget(
                        text: 'Delete Account',
                        color: Colors.red,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    alignment: Alignment.center,
                                    height: 290.h,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.whiteColor,
                                    ),
                                    child: Column(children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: Image.asset(
                                                'assets/icons/cancel_icon.png',
                                              )),
                                        ),
                                      ),
                                      verticalSpace(19),
                                      Text(
                                        'Delete account confirmation',
                                        style: AppTextStyles.font20.copyWith(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      verticalSpace(12),
                                      Text(
                                        'Are you sure you want to delete this account? Note that this action is irreversible and all your info will be wiped from our record',
                                        style: AppTextStyles.font14.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff333333)),
                                        textAlign: TextAlign.justify,
                                      ),
                                      verticalSpace(37),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 48.h,
                                            width: 130.w,
                                            child: ButtonWidget(
                                              text: 'Cancel',
                                              color: const Color(0xffEEEFEF),
                                              textColor: AppColors.primaryColor,
                                              onTap: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 48.h,
                                            width: 130.w,
                                            child: ButtonWidget(
                                              text: 'Confirm',
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await deleteAcct
                                                    .deleteAccount();
                                                if (deleteAcct.status ==
                                                        false &&
                                                    context.mounted) {
                                                  showMessage(context,
                                                      deleteAcct.message);
                                                  return;
                                                }

                                                if (deleteAcct.status == true &&
                                                    context.mounted) {
                                                  showMessage(context, 
                                                      deleteAcct.message);

                                                  nextScreen(context, 
                                                      const SignUpScreen());
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                );
                              });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
