import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class LogDetailsScreen extends StatelessWidget {
  const LogDetailsScreen(
      {super.key, required this.firstName, required this.lastName});

  final String firstName;
  final String lastName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Log details',
                    style: AppTextStyles.font18.copyWith(
                      color: AppColors.mainTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                verticalSpace(48),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/profile_avatar.png'),
                    ),
                    horizontalSpace(17),
                    Text(
                      '$firstName $lastName',
                      style: AppTextStyles.font18.copyWith(
                        color: AppColors.mainTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                LogDetailsSection(),
                LogDetailsSection(),
                LogDetailsSection(),
                verticalSpace(52),
                Container(
                  height: 486.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffE8E8E8)),
                  child: Column(
                    children: [
                      Container(
                        height: 34.h,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 7, horizontal: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          color: Color(0xffB0D3EB),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Event Type',
                              style: AppTextStyles.font12.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            Text(
                              'Event Location',
                              style: AppTextStyles.font12.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTextColor,
                              ),
                            ),
                            Text(
                              'Event Date',
                              style: AppTextStyles.font12.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTextColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpace(20),
                      EventDetailsSection(
                        type: 'Airtime Purchase',
                        location: 'Lagos',
                        date: '12th May 2024',
                      ),
                      verticalSpace(20),
                       EventDetailsSection(
                        type: 'Data Purchase',
                        location: 'Ibadan',
                        date: '8th May 2024',
                      ),
                        verticalSpace(20),
                       EventDetailsSection(
                        type: 'Change Email',
                        location: '-',
                        date: '8th May 2024',
                      ),
                        verticalSpace(20),
                       EventDetailsSection(
                        type: 'Change Password',
                        location: '-',
                        date: '8th May 2024',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventDetailsSection extends StatelessWidget {
  const EventDetailsSection({
    super.key,
    required this.type,
    required this.location,
    required this.date,
  });
  final String type;
  final String location;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              type,
              style: AppTextStyles.font12.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
              ),
            ),
          ),
          Text(
            location,
            style: AppTextStyles.font12.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          Text(
            date,
            style: AppTextStyles.font12.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class LogDetailsSection extends StatelessWidget {
  const LogDetailsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Device',
            style: AppTextStyles.font14.copyWith(
              color: AppColors.mainTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Iphone X',
            style: AppTextStyles.font16.copyWith(
              color: AppColors.mainTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
