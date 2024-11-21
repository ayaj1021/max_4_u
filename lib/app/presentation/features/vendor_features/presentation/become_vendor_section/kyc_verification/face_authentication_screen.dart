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
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

class FaceAuthenticationScreen extends StatefulWidget {
  const FaceAuthenticationScreen({super.key});

  @override
  State<FaceAuthenticationScreen> createState() =>
      _FaceAuthenticationScreenState();
}

class _FaceAuthenticationScreenState extends State<FaceAuthenticationScreen> {
  File? image;

  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) return;

  //     final imageTemporary = File(image.path);

  //     setState(() {
  //       this.image = imageTemporary;
  //     });
  //   } on PlatformException catch (e) {
  //     log('Failed to pick image $e');
  //   }
  // }

  Future pickImage() async {  
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
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

  // Compress the image using the image package
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

  // Helper function to write the compressed image to a file
  Future<File> _writeCompressedImageToFile(List<int> imageBytes) async {
    final tempDir = Directory.systemTemp;
    final tempFile = File('${tempDir.path}/compressed_image.jpg');
    return await tempFile.writeAsBytes(imageBytes);
  }

  Future<void> convertImage(String inputPath, String format) async {
    final outputPath = path.join(
      (await getTemporaryDirectory()).path,
      '${path.basenameWithoutExtension(inputPath)}.$format',
    );

    final inputImage = File(inputPath).readAsBytesSync();
    final decodedImage = img.decodeImage(inputImage);

    if (decodedImage == null) {
      throw Exception('Failed to decode image');
    }

    List<int>? encodedImage;
    if (format.toLowerCase() == 'png') {
      encodedImage = img.encodePng(decodedImage);
    } else if (format.toLowerCase() == 'jpg' ||
        format.toLowerCase() == 'jpeg') {
      encodedImage = img.encodeJpg(decodedImage);
    } else {
      throw Exception('Unsupported format');
    }

    final outputImage = File(outputPath);
    await outputImage.writeAsBytes(encodedImage);

    // Update the image to the converted format for display
    setState(() {
      image = outputImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BecomeAVendorProvider>(builder: (context, uploadPhoto, _) {
      return BusyOverlay(
        show: uploadPhoto.state == ViewState.Busy,
        title: uploadPhoto.message,
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 41, horizontal: 14),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      horizontalSpace(80),
                      Text(
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
                      style: AppTextStyles.font18.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(32),
                  Text(
                    'Tap on image below to photo',
                    style: AppTextStyles.font14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(17),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                      //_convertImage(image!.path, 'png');
                    },
                    child: Container(
                      height: 211.h,
                      width: 211.w,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.whiteColor),
                      child: SizedBox(
                        height: 159.h,
                        width: 159.w,
                        child: ClipOval(
                            child: image != null
                                ? Image.file(image!, fit: BoxFit.cover)
                                : Image.asset(
                                    'assets/images/face_auth_placeholder_image.png',
                                    scale: 4,
                                  )
                            //CameraPreview(_cameraController!)
                            ),
                      ),
                    ),
                  ),
                  verticalSpace(31),
                  Container(
                    alignment: Alignment.center,
                    // height: 87.h,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffFBFFE4)),
                    child: Text(
                      'Use a well-lit environment, face the the camera directly, remove hats , sunshades and any face coverings',
                      style: AppTextStyles.font14.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff333333),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(150),
                  ButtonWidget(
                    text: 'Submit',
                    onTap: () async {
                      if (image == null) {
                        showMessage(context, 'Photo is required',
                            isError: true);
                        return;
                      }
                      String fileName = image!.path.split('/').last;

                      await uploadPhoto.uploadPhoto(
                          image: image!, fileName: fileName);

                      if (uploadPhoto.status == false && context.mounted) {
                        Navigator.pop(context);
                        showMessage(
                          context,
                          uploadPhoto.message,
                          isError: true,
                        );
                        return;
                      }
                      if (uploadPhoto.status == true && context.mounted) {
                        showMessage(
                          context,
                          uploadPhoto.message,
                          // isError: true,
                        );
                        nextScreen(context, BecomeVendorScreen());
                      }
                    },
                  )
                ],
              ),
            ),
          )),
        ),
      );
    });
  }
}
