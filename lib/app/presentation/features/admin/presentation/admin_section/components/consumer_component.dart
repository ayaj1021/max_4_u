import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/encryt_data/encrypt_data.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/user_details_section/user_details_screen.dart';

import 'package:max_4_u/app/provider/admin_section/get_all_app_users_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CustomersComponent extends StatefulWidget {
  const CustomersComponent({super.key});

  @override
  State<CustomersComponent> createState() => _CustomersComponentState();
}

class _CustomersComponentState extends State<CustomersComponent> {
  String firstName = '';
  String lastName = '';
  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllAppUsers>(
      builder: (context, getAllAppUsers, _) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'All Consumers',
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
                  : getAllAppUsers.allAppUsers.data == null
                      ? Center(
                          child: Text(
                            'No data',
                            style: AppTextStyles.font14.copyWith(
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      : getAllAppUsers.allAppUsers.data!.isEmpty
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
                                  'No customers yet',
                                  style: AppTextStyles.font14.copyWith(
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          : Column(
                              children: List.generate(
                                  getAllAppUsers.allAppUsers.data!.length,
                                  (index) {
                                //  final data = getAllAppUsers.allAppUsers.data![index];
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        final userId = EncryptData.decryptAES(
                                            '${getAllAppUsers.allAppUsers.data![0].uniqueId}');
                                        nextScreen(
                                          context,
                                          UserDetailsScreen(
                                            name:
                                                '${getAllAppUsers.firstName} ${getAllAppUsers.lastName}',
                                            userType: 'Consumer',
                                            userId: userId,
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 48.h,
                                        width: 332.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  '${getAllAppUsers.firstName} ${getAllAppUsers.lastName}',
                                                  style: AppTextStyles.font14
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xff475569)),
                                                ),
                                                verticalSpace(4),
                                                Text(
                                                  '${getAllAppUsers.phoneNumber}',
                                                  style: AppTextStyles.font16
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color(
                                                              0xff475569)),
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
                                                        BorderRadius.circular(
                                                            49),
                                                    color: getAllAppUsers
                                                                .allAppUsers
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
                                                                      .allAppUsers
                                                                      .data![
                                                                          index]
                                                                      .status ==
                                                                  'active'
                                                              ? Color(
                                                                  0xff27AE60)
                                                              : Color(
                                                                  0xff4D4C4A),
                                                    ),
                                                    horizontalSpace(6),
                                                    Text(
                                                      '${getAllAppUsers.allAppUsers.data![index].status}',
                                                      style: AppTextStyles.font12.copyWith(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: getAllAppUsers
                                                                      .allAppUsers
                                                                      .data![
                                                                          index]
                                                                      .status ==
                                                                  'active'
                                                              ? Color(
                                                                  0xff27AE60)
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
                                      color: AppColors.blackColor
                                          .withOpacity(0.05),
                                    ),
                                    verticalSpace(13),
                                  ],
                                );
                              }),
                            )
            ],
          ),
        );
      },
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget.rectangular({
    super.key,
    this.height,
    this.width,
  });

  const ShimmerWidget.circular({
    super.key,
    this.height,
    this.width,
  });
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xffE6E6E6)),
      ),
    );
  }
}
