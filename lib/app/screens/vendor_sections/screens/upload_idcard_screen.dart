import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class UploadIdCardScreen extends StatefulWidget {
  const UploadIdCardScreen({super.key});

  @override
  State<UploadIdCardScreen> createState() => _UploadIdCardScreenState();
}

class _UploadIdCardScreenState extends State<UploadIdCardScreen> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
     
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeAVendorProvider>(builder: (context, uploadImage, _) {
      return BusyOverlay(
        child: Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
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
                    horizontalSpace(112),
                    const Text(
                      'Upload ID',
                      style: AppTextStyles.font18,
                    )
                  ],
                ),
                verticalSpace(64),
                Text(
                  'Upload Valid ID',
                  style: AppTextStyles.font14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                verticalSpace(8),
                Container(
                //  alignment: Alignment.center,
                  height: 161.h,
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.whiteColor,
                  ),
                  child: image != null
                      ? ClipRect(child: Image.file(image!, fit: BoxFit.cover))
                      : GestureDetector(
                          onTap: () {
                            log('tapped');
                            pickImage();
                          },
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 37.h,
                              width: 149.w,
                              // padding: const EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color(0xffD9EAF5),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.camera_alt_outlined,
                                    color: AppColors.primaryColor,
                                    size: 16,
                                  ),
                                  horizontalSpace(4),
                                  Text(
                                    'Upload image',
                                    style: AppTextStyles.font14.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                verticalSpace(387),
                ButtonWidget(
                  text: 'Submit',
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )),
        ),
      );
    });
  }
}
