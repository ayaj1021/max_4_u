import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/admin_section/approve_vendor_request_provider.dart';
import 'package:max_4_u/app/provider/admin_section/deny_vendor_request_provider.dart';
import 'package:max_4_u/app/screens/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class RequestsDetailsScreen extends StatelessWidget {
  const RequestsDetailsScreen({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.uniqueId,
    required this.bvnNo,
    required this.ninNo,
    required this.selfiePhoto,
    required this.idPhoto,
    required this.userType,
  });

  final String name;
  final String phoneNumber;
  final String uniqueId;
  final String bvnNo;
  final String ninNo;
  final String selfiePhoto;
  final String idPhoto;
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Consumer2<DenyVendorRequestProvider, ApproveVendorRequestProvider>(
        builder: (context, denyVendor, approveRequest, _) {
      return BusyOverlay(
        show: denyVendor.state == ViewState.Busy,
        title: denyVendor.message,
        child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back)),
                          horizontalSpace(125),
                           Text(
                            'Details',
                            style: AppTextStyles.font18,
                          ),
                        ],
                      ),
                      verticalSpace(25),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/images/profile_avatar.png'),
                          ),
                          horizontalSpace(18),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$name',
                                style: AppTextStyles.font20.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1A1A1A),
                                ),
                              ),
                              verticalSpace(6),
                              Text(
                                phoneNumber,
                                style: AppTextStyles.font16.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff1A1A1A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(32),
                      Text(
                        'Bvn & Nin number',
                        style: AppTextStyles.font16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      verticalSpace(12),
                      Container(
                        height: 86.h,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffE8E8E8),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'BVN number:',
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                horizontalSpace(11),
                                Text(
                                  bvnNo,
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mainTextColor,
                                  ),
                                )
                              ],
                            ),
                            verticalSpace(14),
                            Row(
                              children: [
                                Text(
                                  'NIN number:',
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                horizontalSpace(11),
                                Text(
                                  ninNo,
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mainTextColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(24),
                      Text(
                        'Uploaded selfie photo',
                        style: AppTextStyles.font16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      verticalSpace(12),
                      Container(
                        height: 150.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffE8E8E8),
                        ),
                        child: ClipRRect(
                          child: Image.network(
                            selfiePhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      verticalSpace(24),
                      Text(
                        'ID photo',
                        style: AppTextStyles.font16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff1A1A1A),
                        ),
                      ),
                      verticalSpace(12),
                      Container(
                        height: 150.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffE8E8E8),
                        ),
                        child: ClipRRect(
                          child: Image.network(
                            idPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                userType == 'approved'
                    ? SizedBox.shrink()
                    : Positioned(
                        bottom: 0,
                        child: Container(
                          height: 76.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(16),
                          decoration:
                              BoxDecoration(color: AppColors.whiteColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 44.h,
                                width: 160.w,
                                child: ButtonWidget(
                                  onTap: () async {
                                    await denyVendor.denyVendorRequest(
                                        userId: uniqueId);

                                    if (denyVendor.status == false &&
                                        context.mounted) {
                                      showMessage(context, denyVendor.message,
                                          isError: true);
                                      return;
                                    }
                                    if (denyVendor.status == true &&
                                        context.mounted) {
                                      showMessage(
                                        context,
                                        denyVendor.message,
                                      );
                                    }
                                  },
                                  text: 'Deny request',
                                  color: Color(0xffE6E6E6),
                                  textColor: Color(0xffFF0000),
                                ),
                              ),
                              SizedBox(
                                height: 44.h,
                                width: 160.w,
                                child: ButtonWidget(
                                  onTap: () async {
                                    await approveRequest.approveVendorRequest(
                                        userId: uniqueId);

                                    if (approveRequest.status == false &&
                                        context.mounted) {
                                      showMessage(context, denyVendor.message,
                                          isError: true);
                                      return;
                                    }
                                    if (approveRequest.status == true &&
                                        context.mounted) {
                                      showMessage(
                                        context,
                                        denyVendor.message,
                                      );
                                      nextScreen(context, DashBoardScreen());
                                    }
                                  },
                                  text: 'Approve request',
                                  color: Color(0xffE6E6E6),
                                  textColor: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
