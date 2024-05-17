import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/auto_renewal_screen.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/customer_details_tab_screen.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/customers_transaction_screen.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/button_widget.dart';

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({super.key});

  @override
  State<CustomerDetailsPage> createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    const Text(
                      'Details',
                      style: AppTextStyles.font18,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            isTapped = !isTapped;
                          });
                        },
                        child: const Icon(Icons.more_vert))
                  ],
                ),
                verticalSpace(25),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/user_profile_image.png'),
                    ),
                    horizontalSpace(20),
                    Text(
                      'Peace Adedokun',
                      style: AppTextStyles.font20.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.mainTextColor,
                      ),
                    ),
                  ],
                ),
                verticalSpace(17),
                Container(
                  height: 571.h,
                  width: MediaQuery.of(context).size.height,
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
                  decoration: BoxDecoration(
                      color: const Color(0XFFE8E8E8),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        height: 38.h,
                        width: 333.w,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        decoration:
                            const BoxDecoration(color: Color(0xffDADBDD)),
                        child: TabBar(
                          indicator: BoxDecoration(
                              color: const Color(0xffB0D3EB),
                              borderRadius: BorderRadius.circular(6)),
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          labelColor: AppColors.blackColor,
                          tabs: [
                            Container(
                              height: 31.h,
                              width: 152.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Text('Details'),
                            ),
                            Container(
                              height: 31.h,
                              width: 152.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6)),
                              child: const Text('Transaction'),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(25),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            CustomerDetailsTabScreen(),
                            CustomerTransactionScreen(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                verticalSpace(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 44.h,
                      width: 160.w,
                      child: ButtonWidget(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    content: Container(
                                      height: 197.h,
                                      width: 356.w,
                                      // MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 17, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(children: [
                                        Text(
                                          'Remove Customer',
                                          style: AppTextStyles.font18.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.subTextColor,
                                          ),
                                        ),
                                        verticalSpace(15),
                                        Text(
                                          'Are you sure you want to proceed? This action cannot be undone',
                                          style: AppTextStyles.font14.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        verticalSpace(25),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 44.h,
                                              width: 117.w,
                                              child: ButtonWidget(
                                                text: 'Yes, proceed',
                                                color: Color(0xff219653),
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          17,
                                                                      horizontal:
                                                                          23),
                                                              height: 207.h,
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
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
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        67.h,
                                                                    width: 67.w,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/icons/verify_icon.png'),
                                                                  ),
                                                                  verticalSpace(
                                                                      10),
                                                                  Text(
                                                                    'Removed Successfully',
                                                                    style: AppTextStyles
                                                                        .font16
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .mainTextColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  verticalSpace(
                                                                      13),
                                                                  Text(
                                                                    'The customer has been successfully removed from your records.',
                                                                    style: AppTextStyles
                                                                        .font14
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 44.h,
                                              width: 117.w,
                                              child: ButtonWidget(
                                                text: 'No, cancel',
                                                color: const Color(0xffF2C94C),
                                                onTap: () =>
                                                    Navigator.pop(context),
                                              ),
                                            )
                                          ],
                                        )
                                      ]),
                                    ));
                              });
                        },
                        text: 'Remove Customer',
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.primaryColor),
                        textColor: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                      width: 160.w,
                      child: ButtonWidget(
                        text: 'Make Sales',
                        onTap: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
            isTapped
                ? Positioned(
                    right: 0,
                    top: 30,
                    child: GestureDetector(
                      onTap: () =>
                          nextScreen(context, const AutoRenewalScreen()),
                      child: Container(
                        height: 54.h,
                        width: 158.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'View auto renewals',
                          style: AppTextStyles.font14.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subTextColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      )),
    );
  }
}
