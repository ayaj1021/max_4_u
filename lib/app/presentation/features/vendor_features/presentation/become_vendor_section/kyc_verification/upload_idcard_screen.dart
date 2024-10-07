import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/become_vendor_section/become_vendor_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/provider/become_a_vendor_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

class UploadIdCardScreen extends StatefulWidget {
  const UploadIdCardScreen({super.key});

  @override
  State<UploadIdCardScreen> createState() => _UploadIdCardScreenState();
}

class _UploadIdCardScreenState extends State<UploadIdCardScreen> {
  File? image;

  //   // Method to pick an image using FilePicker and return its path
  // Future<String?> pickImage() async {
  //   try {
  //     FilePickerResult? imageResult = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: false,
  //     );

  //     if (imageResult != null) {
  //       return imageResult.files.single.path;
  //     }
  //   } catch (error) {
  //     print('Error picking image: $error');
  //   }
  //   return null;
  // }

  // // Method to compress the picked image
  // Future<File?> compressImage(String imagePath) async {
  //   try {
  //     File imageFile = File(imagePath);
  //     Uint8List imageBytes = await imageFile.readAsBytes();

  //     img.Image? image = img.decodeImage(imageBytes);

  //     if (image != null) {
  //       // Resize and compress the image
  //       img.Image resizedImage = img.copyResize(image, width: 800); // Resize to 800px width
  //       List<int> compressedImage = img.encodeJpg(resizedImage, quality: 85); // Compress to 85% quality

  //       // Write the compressed image to a temporary file
  //       return await _writeCompressedImageToFile(compressedImage);
  //     }
  //   } catch (e) {
  //     print('Error compressing image: $e');
  //   }
  //   return null;
  // }

  // // Helper function to write the compressed image to a file
  // Future<File> _writeCompressedImageToFile(List<int> imageBytes) async {
  //   final tempDir = Directory.systemTemp;
  //   final tempFile = File('${tempDir.path}/compressed_image.jpg');
  //   return await tempFile.writeAsBytes(imageBytes);
  // }

  // // Method to pick the image, compress it, and set it in the state
  // Future<void> pickImageFile() async {
  //   selectedImagePath = await pickImage();

  //   if (selectedImagePath != null) {
  //     // Compress the selected image
  //     File? compressedImage = await compressImage(selectedImagePath!);

  //     setState(() {
  //       image = compressedImage;
  //     });
  //   }
  // }

//   Future<String?> pickImage() async {
//   try {
//     FilePickerResult? imageResult = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );

//     if (imageResult != null && imageResult.files.single.path != null) {
//       return imageResult.files.single.path;
//     } else {
//       print('No image selected or path is null');

//     }
//   } catch (error) {
//     print('Error picking image: $error');
//   }
//   return null;
// }

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;
      final imageTemporary = File(pickedImage.path);

      // Compress the image before uploading
      File? compressedImage = await compressImage(imageTemporary);

      // Set the image to state
      setState(() {
        image = compressedImage;
      });

      // Upload the compressed image
      // if (compressedImage != null) {
      //   await uploadImage(compressedImage);
      // }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

// Future<File?> compressImage(File imagePath) async {
//   try {
//     File imageFile = File(imagePath.path);

//     // Check if the image file exists
//     if (!imageFile.existsSync()) {
//       print('Image file does not exist');
//       return null;
//     }

//     Uint8List imageBytes = await imageFile.readAsBytes();
//     img.Image? image = img.decodeImage(imageBytes);

//     if (image != null) {
//       // Resize and compress the image
//       img.Image resizedImage = img.copyResize(image, width: 800); // Resize to 800px width
//       List<int> compressedImage = img.encodeJpg(resizedImage, quality: 85); // Compress to 85% quality

//       // Write the compressed image to a temporary file
//       return await _writeCompressedImageToFile(compressedImage);
//     } else {
//       print('Error: Could not decode image');
//     }
//   } catch (e) {
//     print('Error compressing image: $e');
//   }
//   return null;
// }

  Future<File?> compressImage(File imageFile) async {
    try {
      Uint8List imageBytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image != null) {
        img.Image resizedImage = img.copyResize(image,
            width: 800); // Resize the image to 800px width
        List<int> compressedImage = img.encodeJpg(resizedImage,
            quality: 85); // Compress with 85% quality

        // Write the compressed image to a temporary file
        return await _writeCompressedImageToFile(compressedImage);
      }
    } catch (e) {
      log('Failed to compress image: $e');
    }
    return null;
  }

  Future<File> _writeCompressedImageToFile(List<int> imageBytes) async {
    try {
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/compressed_image.jpg');
      return await tempFile.writeAsBytes(imageBytes);
    } catch (e) {
      print('Error writing compressed image to file: $e');
      rethrow; // Allow the error to propagate if needed
    }
  }

// Future<void> pickImageFile() async {
//   selectedImagePath = await pickImage();

//   if (selectedImagePath != null) {
//     // Compress the selected image
//     File? compressedImage = await compressImage(selectedImagePath);

//     if (compressedImage != null) {
//       setState(() {
//         image = compressedImage;
//       });
//     } else {
//       print('Compression failed');
//     }
//   } else {
//     print('Image picking failed or canceled');
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeAVendorProvider>(
      builder: (context, uploadImage, _) {
        return BusyOverlay(
          // show: uploadImage.state == ViewState.Busy,
          title: uploadImage.message,
          child: Scaffold(
            body: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
                child: Stack(
                  children: [
                    Column(
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
                          child: image != null
                              ? Image.file(
                                  image!,
                                  //  File(selectedImagePath!),
                                  fit: BoxFit.cover,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    pickImage();
                                    // await pickImageFile();
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera_alt_outlined,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                          horizontalSpace(4),
                                          Text(
                                            'Upload image',
                                            style:
                                                AppTextStyles.font14.copyWith(
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
                              if (image == null) {
                                showMessage(context, 'ID is required',
                                    isError: true);
                                return;
                              }

                              // final imagePath = image;
                              String fileName = image!.path.split('/').last;

                              await uploadImage.uploadNinIdCard(
                                  image: image!.path, fileName: fileName);

                              if (uploadImage.status == false &&
                                  context.mounted) {
                                showMessage(
                                  context,
                                  uploadImage.message,
                                  isError: true,
                                );
                                return;
                              }
                              if (uploadImage.status == true &&
                                  context.mounted) {
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
                    uploadImage.state == ViewState.Busy
                        ? Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor.withOpacity(1.0),
                              ),
                              child: SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CircularProgressIndicator(
                                      strokeWidth: 10,
                                      value: uploadImage.uploadTotal,
                                      valueColor: AlwaysStoppedAnimation(
                                          AppColors.primaryColor),
                                    ),
                                    // Center(
                                    //   child: buildProgress(),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox.shrink()
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
