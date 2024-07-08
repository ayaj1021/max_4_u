import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/vendor_sections/become_vendor_section/become_vendor_screen.dart';
import 'package:max_4_u/app/provider/vendor/become_a_vendor_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class UploadIdCardScreen extends StatefulWidget {
  const UploadIdCardScreen({super.key});

  @override
  State<UploadIdCardScreen> createState() => _UploadIdCardScreenState();
}

class _UploadIdCardScreenState extends State<UploadIdCardScreen> {
  File? image;
  String? selectedImagePath;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);

  //     setState(() {
  //       this.image = imageTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     log('Failed to pick image $e');
  //   }
  // }

  Future<String?> pickImage() async {
    try {
      // Pick image file
      FilePickerResult? imageResult = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (imageResult != null) {
        // Return the path of the selected image file

        return imageResult.files.single.path;
      }
    } catch (error) {
      print('Error picking image: $error');
      // Handle the error
    }

    return null;
  }

  Future<void> pickImageFile() async {
    selectedImagePath = await pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeAVendorProvider>(
      builder: (context, uploadImage, _) {
        return BusyOverlay(
          show: uploadImage.state == ViewState.Busy,
          title: uploadImage.message,
          child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                        horizontalSpace(112),
                         Text(
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
                      height: 171.h,
                      padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.whiteColor,
                      ),
                      child: selectedImagePath != null
                          ? Image.file(
                              File(selectedImagePath!),
                              fit: BoxFit.cover,
                            )
                          : GestureDetector(
                              onTap: () async {
                                await pickImageFile();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                    verticalSpace(300),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       log(selectedImagePath!.split('/').last);
                    //     },
                    //     child: Text('press')),
                    verticalSpace(30),
                    ButtonWidget(
                        text: 'Submit',
                        onTap: () async {
                          if (selectedImagePath == null) {
                            showMessage(context, 'ID is required',
                                isError: true);
                            return;
                          }

                          // final imagePath = image;
                          String fileName = selectedImagePath!.split('/').last;

                          await uploadImage.uploadNinIdCard(
                              image: selectedImagePath!, fileName: fileName);

                          if (uploadImage.status == false && context.mounted) {
                            showMessage(
                              context,
                              uploadImage.message,
                              isError: true,
                            );
                            return;
                          }
                          if (uploadImage.status == true && context.mounted) {
                            showMessage(
                              context,
                              uploadImage.message,
                              // isError: true,
                            );
                            nextScreen(context, BecomeVendorScreen());
                          }
                        })
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
