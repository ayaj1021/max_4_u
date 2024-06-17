import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/database/database.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/change_email_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String firstName = '';
  String lastName = '';
  String userId = '';
  String phoneNumber = '';
  String email = '';

  @override
  void initState() {
    getNames();
    super.initState();
  }

  getNames() async {
    final name = await SecureStorage().getFirstName();
    final surname = await SecureStorage().getLastName();
    final id = await SecureStorage().getUniqueId();
    final number = await SecureStorage().getPhoneNumber();
    final userEmail = await SecureStorage().getEmail();

    setState(() {
      firstName = name;
      lastName = surname;
      userId = id;
      phoneNumber = number;
      email = userEmail;
    });
  }

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChangeEmailProvider, ReloadUserDataProvider>(
        builder: (context, changeEmail, reloadData, _) {
          final phoneNumber = EncryptData.decryptAES('${reloadData.loadData.userData![0].mobileNumber}');
          final firstName = EncryptData.decryptAES('${reloadData.loadData.userData![0].firstName}');
          final lastName = EncryptData.decryptAES('${reloadData.loadData.userData![0].lastName}');
          final email = EncryptData.decryptAES('${reloadData.loadData.userData![0].email}');
      return BusyOverlay(
        show: changeEmail.state == ViewState.Busy,
        title: changeEmail.message,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                    horizontalSpace(109),
                     Text(
                      'Edit profile',
                      style: AppTextStyles.font18,
                    )
                  ],
                ),
                verticalSpace(37),
                Container(
                  height: 105.h,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 74.h,
                        width: 74.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: const Color(0xff333333),
                          ),
                        ),
                        child: ClipOval(
                          child:
                              Image.asset('assets/images/profile_avatar.png'),
                        ),
                      ),
                      horizontalSpace(16),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Edit image',
                      //       style: AppTextStyles.font14.copyWith(
                      //         color: AppColors.primaryColor,
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                verticalSpace(20),
                Container(
                  height: 364.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EditProfileComponent(
                        editIcon: SizedBox(),
                        title: 'First name',
                        value: firstName,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        editIcon: SizedBox(),
                        title: 'Last name',
                        value: lastName,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        editIcon: SizedBox(),
                        title: 'Phone Number',
                        value: phoneNumber,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        onTap: () {
                          editProfileAlertDialog(
                            context,
                            title: 'Edit Email',
                            controller: _emailController,
                          );
                        },
                        title: 'Email',
                        value: email,
                      ),
                      verticalSpace(8),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 23.h,
                      //   width: 104.w,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(22),
                      //     color: Color(0xffAE8027).withOpacity(0.2),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 4,
                      //         backgroundColor: Color(0xffAE8027),
                      //       ),
                      //       horizontalSpace(10),
                      //       Text(
                      //         'Unverified',
                      //         style: AppTextStyles.font12.copyWith(
                      //           fontWeight: FontWeight.w600,
                      //           color: Color(0xffAE8027),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // )
                   
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      );
    });
  }

  Future<dynamic> editProfileAlertDialog(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Consumer<ChangeEmailProvider>(
              builder: (context, changeEmail, _) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 23),
                height: 241.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset('assets/icons/cancel_icon.png'),
                        ),
                      ),
                    ),
                    Text(
                      title,
                      style: AppTextStyles.font16.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff333333)),
                    ),
                    TextInputField(
                      controller: changeEmail.emailController,
                      labelText: '',
                      hintText: 'Enter new email',
                    ),
                    verticalSpace(27),
                    ButtonWidget(
                      text: 'Continue',
                      onTap: () async {
                        if (changeEmail.emailController.text.isEmpty) {
                          showMessage(context, 'Email field is required',
                              isError: true);
                          return;
                        }
                        Navigator.pop(context);

                        await changeEmail.changeEmail();
                        if (changeEmail.state == ViewState.Error &&
                            context.mounted) {
                          showMessage(context, changeEmail.message);
                          return;
                        }

                        if (changeEmail.state == ViewState.Success &&
                            context.mounted) {}
                      },
                    )
                  ],
                ),
              ),
            );
          });
        });
  }
}

class EditProfileComponent extends StatelessWidget {
  const EditProfileComponent({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
    this.editIcon,
  });

  final String title;
  final String value;
  final Function()? onTap;
  final Widget? editIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.font20.copyWith(
                  color: const Color(0xff333333), fontWeight: FontWeight.w400),
            ),
            verticalSpace(8),
            Text(
              value,
              style: AppTextStyles.font16.copyWith(
                  color: AppColors.mainTextColor, fontWeight: FontWeight.w400),
            )
          ],
        ),
        SizedBox(
          height: 16.h,
          width: 16.w,
          child: GestureDetector(
              onTap: onTap,
              child: editIcon ?? Image.asset('assets/icons/edit_icon.png')),
        ),
      ],
    );
  }
}
