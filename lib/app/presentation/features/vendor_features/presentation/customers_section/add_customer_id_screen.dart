import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/add_customer_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class AddCustomerIdScreen extends StatefulWidget {
  const AddCustomerIdScreen({super.key});

  @override
  State<AddCustomerIdScreen> createState() => _AddCustomerIdScreenState();
}

class _AddCustomerIdScreenState extends State<AddCustomerIdScreen> {
  final _userIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCustomerProvider>(
      builder: (context, addCustomer, _) {
        return BusyOverlay(
          show: addCustomer.state == ViewState.Busy,
          title: addCustomer.message,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                        horizontalSpace(120),
                         Text(
                          'User ID',
                          style: AppTextStyles.font18,
                        ),
                      ],
                    ),
                    verticalSpace(107),
                    TextInputField(
                      controller: _userIdController,
                      hintText: 'Enter User ID',
                      textInputType: TextInputType.number,
                    ),
                    verticalSpace(64),
                    ButtonWidget(
                        onTap: () async {
                          if (_userIdController.text.isEmpty) {
                            showMessage(context, 'User ID is required',
                                isError: true);
                            return;
                          }
                          await addCustomer.addCustomerWithUserId(
                            userId: _userIdController.text.trim(),
                          );

                          if (addCustomer.status == false && context.mounted) {
                            showMessage(
                              context,
                              addCustomer.message,
                              isError: true,
                            );

                            return;
                          }

                          if (addCustomer.status == true && context.mounted) {
                            showMessage(
                              context,
                              addCustomer.message,
                              // isError: false,
                            );

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17, horizontal: 23),
                                    height: 207.h,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 67.h,
                                          width: 67.w,
                                          child: Image.asset(
                                              'assets/icons/verify_icon.png'),
                                        ),
                                        verticalSpace(10),
                                        Text(
                                          'Added Successfully',
                                          style: AppTextStyles.font16.copyWith(
                                            color: AppColors.mainTextColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        verticalSpace(13),
                                        Text(
                                          'The customer has been successfully added to your records',
                                          style: AppTextStyles.font14.copyWith(
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                        text: 'Add customer')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
