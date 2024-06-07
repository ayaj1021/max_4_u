import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class FaceAuthenticationScreen extends StatefulWidget {
  const FaceAuthenticationScreen({super.key});

  @override
  State<FaceAuthenticationScreen> createState() =>
      _FaceAuthenticationScreenState();
}

class _FaceAuthenticationScreenState extends State<FaceAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
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
                  horizontalSpace(64),
                  const Text(
                    'Face Authentication',
                    style: AppTextStyles.font18,
                  )
                ],
              ),
              verticalSpace(32),
              SizedBox(
                width: 310.w,
                child: Text(
                  'Please ensure the face in the photo matches the one in in your BVN and ID',
                  style: AppTextStyles.font14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(32),
              Container(
                height: 211.h,
                width: 211.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.whiteColor),
                child: SizedBox(
                  height: 189.h,
                  width: 189.w,
                  child: ClipOval(
                    child: Image.asset(
                        'assets/images/face_auth_placeholder_image.png'),
                  ),
                ),
              ),
              verticalSpace(26),
              Text(
                'Make sure your face is in the circle',
                style: AppTextStyles.font12.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff333333),
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(31),
              Container(
                alignment: Alignment.center,
                height: 87.h,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffFBFFE4)),
                child: Text(
                  'Use a well-lit environment, face the the camera directly, remove hats , sunshades and any face coverings',
                  style: AppTextStyles.font12.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace(164),
              ButtonWidget(
                text: 'Submit',
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
