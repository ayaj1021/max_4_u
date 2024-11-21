import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/presentation/features/dashboard/support/widgets/vendor_faq_section.dart';
import 'package:max_4_u/app/provider/faq_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/settings_option_section.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void copyToClipboard(text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    // final Uri phoneNumber = Uri.parse('tel:+2349152330553');
    final Uri whatsapp = Uri.parse('https://wa.me/+2347033070280');
    return Scaffold(body: Consumer2<FaqProvider, AuthProviderImpl>(
        builder: (context, faq, authProv, _) {
      final name = EncryptData.decryptAES(
          '${authProv.resDataData.userData![0].firstName}');
      return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 39, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, $name',
                  style: AppTextStyles.font18.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'How can we help you today?',
                  style: AppTextStyles.font14.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff333333),
                  ),
                ),
                verticalSpace(24),
                Text(
                  'Contact us',
                  style: AppTextStyles.font18.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                verticalSpace(9),
                Container(
                  alignment: Alignment.center,
                  height: 120.h,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    children: [
                      SettingsOptionSection(
                          iconData: Icons.arrow_forward_ios,
                          onTap: () {
                            launchUrl(whatsapp);
                          },
                          icon: 'assets/icons/whatsapp_icon.png',
                          settingOption: '07033070280'),
                      verticalSpace(20),
                      SettingsOptionSection(
                          iconData: Icons.arrow_forward_ios,
                          onTap: () {
                            mailSupport(email: 'maxprecursorltd@gmail.com');
                          },
                          icon: 'assets/icons/sms_icon.png',
                          settingOption: 'maxprecursorltd@gmail.com'),
                      verticalSpace(20),
                      // SettingsOptionSection(
                      //     iconData: Icons.arrow_forward_ios,
                      //     onTap: () {
                      //       _makePhoneCall('+2348097238712');
                      //     },
                      //     icon: 'assets/icons/call_icon.png',
                      //     settingOption: '07038177869'),
                    ],
                  ),
                ),
                // verticalSpace(24),
                // Text(
                //   'Location',
                //   style: AppTextStyles.font18.copyWith(
                //     fontWeight: FontWeight.w400,
                //   ),
                // ),
                // verticalSpace(9),
                // Container(
                //   alignment: Alignment.center,
                //   height: 76.h,
                //   width: MediaQuery.of(context).size.width,
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     color: AppColors.whiteColor,
                //   ),
                //   child: Column(
                //     children: [
                //       Row(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           SizedBox(
                //             height: 20,
                //             width: 20,
                //             child:
                //                 Image.asset('assets/icons/location_icon.png'),
                //           ),
                //           horizontalSpace(12),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 width: 299.w,
                //                 child: Text(
                //                   'No.5 Ajayi avenue. Anifalaje bustop. Akobo. Ibadan, Oyo state',
                //                   style: AppTextStyles.font14.copyWith(
                //                     fontWeight: FontWeight.w400,
                //                   ),
                //                 ),
                //               ),
                // verticalSpace(6),
                // Text(
                //   'Locate using google map',
                //   style: AppTextStyles.font12.copyWith(
                //     fontWeight: FontWeight.w400,
                //     color: AppColors.primaryColor,
                //     decoration: TextDecoration.underline,
                //   ),
                // ),
                // ],
                //   ),
                // ],
                // ),
                //     ],
                //   ),
                // ),
                verticalSpace(24),
                Text(
                  'FAQs',
                  style: AppTextStyles.font18.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                verticalSpace(9),
                Container(
                    alignment: Alignment.center,
                    // height: 250.h,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.whiteColor,
                    ),
                    child: authProv.userLevel == '2'
                        ? VendorFaqSection()
                        : VendorFaqSection()),
              ],
            ),
          ),
        ),
      );
    }));
  }
}

Future<void> mailSupport({required String email}) async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  final emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: encodeQueryParameters(<String, String>{
      'subject': 'Feedback',
      'body': 'Feedback',
    }),
  );
  try {
    await launchUrl(emailLaunchUri);
  } catch (_) {
    print(_.toString());
  }
}
