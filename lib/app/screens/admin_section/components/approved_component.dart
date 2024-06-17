import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/provider/admin_section/get_all_vendors_requests_provider.dart';
import 'package:max_4_u/app/provider/auth_provider.dart';
import 'package:max_4_u/app/screens/admin_section/components/requests_details_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class ApprovedComponent extends StatelessWidget {
  const ApprovedComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<GetAllVendorRequestsProvider, AuthProviderImpl>(
        builder: (context, getAllVendorRequest, authProv, _) {
      return getAllVendorRequest.allVendorRequest.data!.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 56.h,
                  width: 56.w,
                  child: Image.asset('assets/images/no_request_image.png'),
                ),
                verticalSpace(10),
                Text(
                  'No pending requests',
                  style: AppTextStyles.font14.copyWith(
                      fontWeight: FontWeight.w400, color: Color(0xff475569)),
                )
              ],
            ))
          : Column(
              children: List.generate(
                  getAllVendorRequest.allVendorRequest.data!.length, (index) {
                final data = getAllVendorRequest.allVendorRequest.data![index];

                return data.status == 'pending'
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 56.h,
                            width: 56.w,
                            child: Image.asset(
                                'assets/images/no_request_image.png'),
                          ),
                          verticalSpace(10),
                          Text(
                            'No pending requests',
                            style: AppTextStyles.font14.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff475569)),
                          )
                        ],
                      ))
                    : data.status == 'denied'
                        ? Center(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 56.h,
                                width: 56.w,
                                child: Image.asset(
                                    'assets/images/no_request_image.png'),
                              ),
                              verticalSpace(10),
                              Text(
                                'No pending requests',
                                style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff475569)),
                              )
                            ],
                          ))
                        : Column(
                            children: [
                              SizedBox(
                                height: 48.h,
                                width: 332.w,
                                child: GestureDetector(
                                  onTap: () {
                                    nextScreen(
                                        context,
                                        RequestsDetailsScreen(
                                          name:
                                              '${getAllVendorRequest.firstName} ${getAllVendorRequest.lastName}',
                                          phoneNumber: '',
                                          uniqueId:
                                              '${getAllVendorRequest.uniqueId}',
                                          bvnNo: '${data.bvn}',
                                          ninNo: '${data.nin}',
                                          selfiePhoto:
                                              '${authProv.resDataData.siteData?.userImageUrl}${data.vendorImageLink}',
                                          idPhoto:
                                              '${authProv.resDataData.siteData?.idCardUrl}${data.ninImageLink}',
                                          userType: 'approved',
                                        ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: AssetImage(
                                            'assets/images/profile_avatar.png'),
                                      ),
                                      // horizontalSpace(14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${getAllVendorRequest.firstName} ${getAllVendorRequest.lastName}',
                                            //  '${getAllAppUsers.firstName} ${getAllAppUsers.lastName}',
                                            style: AppTextStyles.font14
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff475569)),
                                          ),
                                          verticalSpace(4),
                                          Text(
                                            '${getAllVendorRequest.phoneNumber}',
                                            // '${getAllAppUsers.phoneNumber}',
                                            style: AppTextStyles.font16
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff475569)),
                                          ),
                                        ],
                                      ),
                                      horizontalSpace(41),
                                      // Container(
                                      //     height: 30.h,
                                      //     width: 94.w,
                                      //     alignment: Alignment.center,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius:
                                      //           BorderRadius.circular(49),
                                      //       color: getAllVendorRequest
                                      //                   .allVendorRequest
                                      //                   .data![index]
                                      //                   .status ==
                                      //               'active'
                                      //           ? Color(0xff27AE60)
                                      //               .withOpacity(0.2)
                                      //           : Color(0xffA7A6A3),
                                      //     ),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         CircleAvatar(
                                      //           radius: 2,
                                      //           backgroundColor:
                                      //               getAllVendorRequest
                                      //                           .allVendorRequest
                                      //                           .data![index]
                                      //                           .status ==
                                      //                       'active'
                                      //                   ? Color(0xff27AE60)
                                      //                   : Color(0xff4D4C4A),
                                      //         ),
                                      //         horizontalSpace(6),
                                      //         Text(
                                      //           '${getAllVendorRequest.allVendorRequest.data![index].status}',
                                      //           // '${getAllAppUsers.allAppUsers.data![index].status}',
                                      //           style:
                                      //               AppTextStyles.font12.copyWith(
                                      //             fontWeight: FontWeight.w600,
                                      //             color: getAllVendorRequest
                                      //                         .allVendorRequest
                                      //                         .data![index]
                                      //                         .status ==
                                      //                     'active'
                                      //                 ? Color(0xff27AE60)
                                      //                 : Color(0xff4D4C4A),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ))

                                      Text(
                                        '${data.regDate}',
                                        // '${dateFormat.format(data.regDate as DateTime)}',
                                        style: AppTextStyles.font12.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              verticalSpace(13),
                              Divider(
                                color: AppColors.blackColor.withOpacity(0.05),
                              ),
                              verticalSpace(13),
                            ],
                          );
              }),
            );
    });
  }
}
