import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/user_details_section/user_details_screen.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class VendorsComponent extends StatefulWidget {
  const VendorsComponent({super.key});

  @override
  State<VendorsComponent> createState() => _VendorsComponentState();
}

class _VendorsComponentState extends State<VendorsComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllAppUsers>(context, listen: false).getAlLVendors();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllAppUsers>(builder: (context, getAllAppUsers, _) {
      return SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'All Vendors',
                  style: AppTextStyles.font18.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(Icons.arrow_drop_down)
              ],
            ),
            verticalSpace(20),
            getAllAppUsers.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : getAllAppUsers.allAppVendors.data == null
                    ? Center(
                        child: Text(
                          'No data',
                          style: AppTextStyles.font14.copyWith(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : getAllAppUsers.allAppVendors.data!.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 92.h,
                                  width: 92.w,
                                  child: Image.asset(
                                      'assets/images/no_beneficiary_image.png')),
                              verticalSpace(24),
                              Text(
                                'No vendors yet',
                                style: AppTextStyles.font14.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          )
                        : Column(
                            children: List.generate(
                                getAllAppUsers.allAppVendors.data!.length,
                                (index) {
                              final data =
                                  getAllAppUsers.allAppVendors.data![index];

                              final vendorFirstName =
                                  EncryptData.decryptAES('${data.firstName}');
                              final vendorLastName =
                                  EncryptData.decryptAES('${data.lastName}');
                              final vendorPhoneNumber = EncryptData.decryptAES(
                                  '${data.mobileNumber}');

                              final vendorEmail =
                                  EncryptData.decryptAES('${data.email}');
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 48.h,
                                    width: 332.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        final userId =
                                            '${getAllAppUsers.allAppUsers.data?.responseData?.data?.map((e) => e.id)}';

                                        nextScreen(
                                            context,
                                            UserDetailsScreen(
                                              name:
                                                  '${vendorFirstName} ${vendorLastName}',
                                              userType: 'vendor',
                                              userId: userId,
                                              firstName: '${vendorFirstName}',
                                              lastName: '${vendorLastName}',
                                              phoneNumber:
                                                  '${vendorPhoneNumber}',
                                              email: '${vendorEmail}',
                                              data: [],
                                            ));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: AssetImage(
                                                'assets/images/profile_avatar.png'),
                                          ),
                                          horizontalSpace(14),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${vendorFirstName} ${vendorLastName}',
                                                style: AppTextStyles.font14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xff475569)),
                                              ),
                                              verticalSpace(4),
                                              Text(
                                                '${vendorPhoneNumber}',
                                                style: AppTextStyles.font16
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Color(0xff475569)),
                                              ),
                                            ],
                                          ),
                                          horizontalSpace(41),
                                          Container(
                                              height: 30.h,
                                              width: 94.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(49),
                                                  color: getAllAppUsers
                                                              .allAppVendors
                                                              .data![index]
                                                              .status ==
                                                          'active'
                                                      ? Color(0xff27AE60)
                                                          .withOpacity(0.2)
                                                      : Color(0xffA7A6A3)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 2,
                                                    backgroundColor:
                                                        getAllAppUsers
                                                                    .allAppVendors
                                                                    .data![
                                                                        index]
                                                                    .status ==
                                                                'active'
                                                            ? Color(0xff27AE60)
                                                            : Color(0xff4D4C4A),
                                                  ),
                                                  horizontalSpace(6),
                                                  Text(
                                                    '${getAllAppUsers.allAppVendors.data![index].status}',
                                                    style: AppTextStyles.font12.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: getAllAppUsers
                                                                    .allAppVendors
                                                                    .data![
                                                                        index]
                                                                    .status ==
                                                                'active'
                                                            ? Color(0xff27AE60)
                                                            : Color(
                                                                0xff4D4C4A)),
                                                  )
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  verticalSpace(13),
                                  Divider(
                                    color:
                                        AppColors.blackColor.withOpacity(0.05),
                                  ),
                                  verticalSpace(13),
                                ],
                              );
                            }),
                          )
          ],
        ),
      );
    });
  }
}
