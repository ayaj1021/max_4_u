import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/model/user_response_model.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/user_details_section/details_component.dart';
import 'package:max_4_u/app/presentation/features/admin/presentation/admin_section/components/user_details_section/user_transaction_component.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/users/presentation/view/super_admin_users_screen.dart';
import 'package:max_4_u/app/presentation/features/auth/provider/auth_provider.dart';
import 'package:max_4_u/app/provider/reload_data_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/deactivate_user_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/make_admin_provider.dart';
import 'package:max_4_u/app/presentation/features/super_admin_section/providers/super_admin/remove_admin_provider.dart';
import 'package:max_4_u/app/presentation/features/auto_renewal/presentation/auto_renewal_screen.dart';
import 'package:max_4_u/app/presentation/features/dashboard/dashboard_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.name,
    required this.userType,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.data,
    required this.status,
    required this.uniqueId,
  });
  final String name;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String userType;
  final String userId;
  final String status;
  final String uniqueId;
  final List<Transaction> data;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer5<AuthProviderImpl, DeactivateUserProvider,
            ReloadUserDataProvider, MakeAdminProvider, RemoveAdminProvider>(
        builder: (context, authProv, deactivateUser, reloadData, makeAdmin,
            removeAdmin, _) {
      return Scaffold(
        body: SafeArea(
          child: BusyOverlay(
            show: deactivateUser.state == ViewState.Busy,
            title: deactivateUser.message,
            child: SingleChildScrollView(
              child: BusyOverlay(
                show: makeAdmin.state == ViewState.Busy,
                title: makeAdmin.message,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.arrow_back)),
                          Text(
                            'Details',
                            style: AppTextStyles.font18.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          authProv.userLevel == '5'
                              ? PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'Page1') {
                                      nextScreen(context, AutoRenewalScreen());
                                    }
                                  },
                                  elevation: 0,
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem<String>(
                                        value: 'Page1',
                                        child: Text(
                                          'Auto renewal',
                                          style: AppTextStyles.font14.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.mainTextColor),
                                        ),
                                      ),
                                      widget.userType == 'Admin'
                                          ? PopupMenuItem<String>(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          content: Container(
                                                            height: 197.h,
                                                            width: 356.w,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    'Remove from admin',
                                                                    style: AppTextStyles
                                                                        .font18
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .subTextColor,
                                                                    )),
                                                                verticalSpace(
                                                                    15),
                                                                Text(
                                                                  'Are you sure you want to proceed? This action cannot be undone',
                                                                  style: AppTextStyles
                                                                      .font14
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: AppColors
                                                                        .textColor,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                verticalSpace(
                                                                    20),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: 117
                                                                            .w,
                                                                        height: 44
                                                                            .h,
                                                                        child:
                                                                            ButtonWidget(
                                                                          color:
                                                                              Color(0xff219653),
                                                                          textColor:
                                                                              AppColors.whiteColor,
                                                                          text:
                                                                              'Yes, Proceed',
                                                                          onTap:
                                                                              () async {
                                                                            Navigator.pop(context);
                                                                            await removeAdmin.removeAdmin(userId: widget.userId);

                                                                            if (removeAdmin.status == false &&
                                                                                context.mounted) {
                                                                              showMessage(
                                                                                context,
                                                                                removeAdmin.message,
                                                                                isError: true,
                                                                              );
                                                                              return;
                                                                            }

                                                                            if (removeAdmin.status == true &&
                                                                                context.mounted) {
                                                                              // ScaffoldMessenger.of(context)
                                                                              //     .showSnackBar(
                                                                              //   SnackBar(
                                                                              //     content: Text(removeAdmin.message),
                                                                              //   ),
                                                                              // );
                                                                              showMessage(
                                                                                context,
                                                                                removeAdmin.message,
                                                                                // isError: true,
                                                                              );

                                                                              await reloadData.reloadUserData();

                                                                              nextScreen(context, DashBoardScreen());
                                                                            }
                                                                          },
                                                                        )),
                                                                    SizedBox(
                                                                        width: 117
                                                                            .w,
                                                                        height: 44
                                                                            .h,
                                                                        child: ButtonWidget(
                                                                            onTap: () =>
                                                                                Navigator.pop(context),
                                                                            color: Color(0xffF2C94C),
                                                                            text: 'No, Cancel')),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                    });
                                              },
                                              value: 'Page2',
                                              child: Text(
                                                'Remove Admin',
                                                style: AppTextStyles.font14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .mainTextColor),
                                              ),
                                            )
                                          : PopupMenuItem<String>(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          content: Container(
                                                            height: 197.h,
                                                            width: 356.w,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .whiteColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    'Make admin',
                                                                    style: AppTextStyles
                                                                        .font18
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .subTextColor,
                                                                    )),
                                                                verticalSpace(
                                                                    15),
                                                                Text(
                                                                  'Are you sure you want to proceed? This action cannot be undone',
                                                                  style: AppTextStyles
                                                                      .font14
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: AppColors
                                                                        .textColor,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                verticalSpace(
                                                                    20),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: 117
                                                                            .w,
                                                                        height: 44
                                                                            .h,
                                                                        child:
                                                                            ButtonWidget(
                                                                          color:
                                                                              Color(0xff219653),
                                                                          textColor:
                                                                              AppColors.whiteColor,
                                                                          text:
                                                                              'Yes, Proceed',
                                                                          onTap:
                                                                              () async {
                                                                            Navigator.pop(context);
                                                                            await makeAdmin.makeAdmin(userId: widget.userId);

                                                                            if (makeAdmin.status == false &&
                                                                                context.mounted) {
                                                                              // showMessage(
                                                                              //   context,
                                                                              //   makeAdmin.message,
                                                                              //   isError: true,
                                                                              // );
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      content: Container(
                                                                                        height: 300,
                                                                                        width: 300,
                                                                                        color: Colors.red,
                                                                                      ),
                                                                                    );
                                                                                  });
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(makeAdmin.message),
                                                                                ),
                                                                              );
                                                                              return;
                                                                            }

                                                                            if (makeAdmin.status == true &&
                                                                                context.mounted) {
                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text(makeAdmin.message),
                                                                                ),
                                                                              );

                                                                              await reloadData.reloadUserData();

                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      contentPadding: EdgeInsets.zero,
                                                                                      content: Container(),
                                                                                    );
                                                                                  });

                                                                              nextScreen(context, DashBoardScreen());
                                                                            }
                                                                          },
                                                                        )),
                                                                    SizedBox(
                                                                        width: 117
                                                                            .w,
                                                                        height: 44
                                                                            .h,
                                                                        child: ButtonWidget(
                                                                            onTap: () =>
                                                                                Navigator.pop(context),
                                                                            color: Color(0xffF2C94C),
                                                                            text: 'No, Cancel')),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ));
                                                    });
                                              },
                                              value: 'Page2',
                                              child: Text(
                                                'Make Admin',
                                                style: AppTextStyles.font14
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .mainTextColor),
                                              ),
                                            ),
                                    ];
                                  },
                                )
                              : PopupMenuButton(
                                  onSelected: (value) {
                                    if (value == 'Page1') {
                                      nextScreen(context, AutoRenewalScreen());
                                    }
                                  },
                                  elevation: 0,
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      PopupMenuItem<String>(
                                        value: 'Page1',
                                        child: Text(
                                          'Auto renewal',
                                          style: AppTextStyles.font14.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.mainTextColor),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                        ],
                      ),
                      verticalSpace(25),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                AssetImage('assets/images/profile_avatar.png'),
                          ),
                          horizontalSpace(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: AppTextStyles.font20
                                    .copyWith(fontWeight: FontWeight.w500),
                              ),
                              verticalSpace(8),
                              Text(
                                widget.userType,
                                style: AppTextStyles.font12.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.mainTextColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      verticalSpace(17),
                      Container(
                        height: 571.h,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: (Color(0xffE8E8E8))),
                        child: Column(
                          children: [
                            Container(
                              height: 38.h,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: (Color(0xffDADBDD))),
                              child: TabBar(
                                controller: _tabController,
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                indicator:
                                    BoxDecoration(color: Color(0xffB0D2EA)),
                                tabs: [
                                  Container(
                                    width: 164.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      'Details',
                                      style: AppTextStyles.font14.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.mainTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 164.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      'Transactions',
                                      style: AppTextStyles.font12.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.mainTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(24),
                            Expanded(
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                  DetailsComponent(
                                    firstName: widget.firstName,
                                    lastName: widget.lastName,
                                    phoneNumber: widget.phoneNumber,
                                    email: widget.email,
                                  ),
                                  UserTransactionsComponent(
                                    data: [],
                                    userId: widget.userId,
                                  ),
                                ])),
                          ],
                        ),
                      ),
                      verticalSpace(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 180.w,
                            height: 44.h,
                            child: ButtonWidget(
                              border: Border.all(color: AppColors.primaryColor),
                              color: AppColors.whiteColor,
                              textColor: AppColors.primaryColor,
                              text: widget.status == 'active'
                                  ? 'Deactivate Customer'
                                  : 'Activate Customer',
                              onTap: () async {
                                await widget.status == 'active'
                                    ? deactivateUser.deactivateUser(
                                        userId: widget.uniqueId)
                                    : deactivateUser.activateUser(
                                        userId: widget.uniqueId);

                                if (deactivateUser.status == false &&
                                    context.mounted) {
                                  showMessage(
                                    context,
                                    deactivateUser.message,
                                    isError: true,
                                  );
                                  return;
                                }

                                if (deactivateUser.status == true &&
                                    context.mounted) {
                                  showMessage(
                                    context,
                                    deactivateUser.message,
                                    // isError: true,
                                  );

                                  await reloadData.reloadUserData();

                                  nextScreen(context, SuperAdminUserScreen());
                                }
                              },
                            ),
                          ),
                          SizedBox(
                              width: 170.w,
                              height: 44.h,
                              child: ButtonWidget(
                                  onTap: () =>
                                      nextScreen(context, DashBoardScreen()),
                                  text: 'Make Sales')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
