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
import 'package:max_4_u/app/utils/white_space.dart';
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

  //final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChangeEmailProvider, ReloadUserDataProvider>(
        builder: (context, changeEmail, reloadData, _) {
      final phoneNumber = EncryptData.decryptAES(
          '${reloadData.loadData.userData![0].mobileNumber}');
      final firstName = EncryptData.decryptAES(
          '${reloadData.loadData.userData![0].firstName}');
      final lastName = EncryptData.decryptAES(
          '${reloadData.loadData.userData![0].lastName}');
      final email =
          EncryptData.decryptAES('${reloadData.loadData.userData![0].email}');
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
                    horizontalSpace(115),
                    Text(
                      'Profile',
                      style: AppTextStyles.font18.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                verticalSpace(37),
                CircleAvatar(
                  radius: 45,
                  backgroundImage:
                      AssetImage('assets/images/profile_avatar.png'),
                ),
                horizontalSpace(16),
                verticalSpace(20),
                Container(
                  height: 400.h,
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
                        title: 'First name',
                        value: firstName,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        title: 'Last name',
                        value: lastName,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        title: 'Phone Number',
                        value: phoneNumber,
                      ),
                      verticalSpace(32),
                      EditProfileComponent(
                        title: 'Email',
                        value: email,
                      ),
                      verticalSpace(8),
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
}

class EditProfileComponent extends StatelessWidget {
  const EditProfileComponent({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  final String title;
  final String value;
  final Function()? onTap;

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
      ],
    );
  }
}
