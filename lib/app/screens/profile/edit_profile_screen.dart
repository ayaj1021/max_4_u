import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Text(
                  'Edit profile',
                  style: AppTextStyles.font18,
                )
              ],
            ),
            verticalSpace(37),
            Container(
              height: 105.h,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
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
                        width: 4,
                        color: const Color(0xff333333),
                      ),
                    ),
                    child: ClipOval(
                      child:
                          Image.asset('assets/images/user_profile_image.png'),
                    ),
                  ),
                  horizontalSpace(16),
                  Row(
                    children: [
                      const Icon(Icons.camera_alt_outlined,
                          color: AppColors.primaryColor),
                      horizontalSpace(4),
                      Text(
                        'Edit image',
                        style: AppTextStyles.font14.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(20),
            Container(
              height: 354.h,
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 25),
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
                    value: 'Praise',
                  ),
                  verticalSpace(32),
                  EditProfileComponent(
                    editIcon: SizedBox(),
                    title: 'Last name',
                    value: 'Adedokun',
                  ),
                  verticalSpace(32),
                  EditProfileComponent(
                    editIcon: SizedBox(),
                    title: 'Phone Number',
                    value: '08169784022',
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
                    value: 'tobilobaphilipson@gmail.com',
                  ),
                  verticalSpace(8),
                  Container(
                    alignment: Alignment.center,
                    height: 23.h,
                    width: 104.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0xffAE8027).withOpacity(0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xffAE8027),
                        ),
                        horizontalSpace(10),
                        Text(
                          'Unverified',
                          style: AppTextStyles.font12.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Color(0xffAE8027),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<dynamic> editProfileAlertDialog(
    BuildContext context, {
    required String title,
    required TextEditingController controller,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 23),
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
                    controller: controller,
                    labelText: '',
                  ),
                  verticalSpace(27),
                  ButtonWidget(
                    text: 'Continue',
                    onTap: () {},
                  )
                ],
              ),
            ),
          );
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
              style: AppTextStyles.font14.copyWith(
                  color: const Color(0xff333333), fontWeight: FontWeight.w400),
            ),
            verticalSpace(8),
            Text(
              value,
              style: AppTextStyles.font14.copyWith(
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
