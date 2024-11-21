import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/customers_section/add_customer_id_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/customers_section/add_customer_number_screen.dart';
import 'package:max_4_u/app/presentation/features/vendor_features/presentation/customers_section/customer_details_page.dart';
import 'package:max_4_u/app/presentation/features/admin/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:provider/provider.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GetAllCustomersProvider>(context, listen: false)
          .getAllCustomers();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Customers',
                style: AppTextStyles.font18,
              ),
              // verticalSpace(25),
              // TextInputField(
              //   controller: _searchController,
              //   hintText: 'Search for a customer',
              //   prefixIcon: const Icon(
              //     Icons.search,
              //     color: Color(0xff4F4F4F),
              //   ),
              // ),
              verticalSpace(25),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Add Customer',
                                style: AppTextStyles.font18.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              verticalSpace(37),
                              GestureDetector(
                                onTap: () => nextScreen(
                                    context, AddCustomerNumberScreen()),
                                child: Text(
                                  'Add Using Phone Number/Email',
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTextColor,
                                  ),
                                ),
                              ),
                              verticalSpace(40),
                              GestureDetector(
                                onTap: () =>
                                    nextScreen(context, AddCustomerIdScreen()),
                                child: Text(
                                  'Add Using User ID',
                                  style: AppTextStyles.font14.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.subTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 18,
                      ),
                    ),
                    horizontalSpace(4),
                    Text(
                      'Add Customer',
                      style: AppTextStyles.font14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ),

              Consumer<GetAllCustomersProvider>(
                  builder: (context, getAllCustomer, _) {
                return getAllCustomer.data.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpace(124),
                            SizedBox(
                                height: 92.h,
                                width: 92.w,
                                child: Image.asset(
                                    'assets/images/no_beneficiary_image.png')),
                            verticalSpace(24),
                            Text(
                              'You have no customers yet',
                              style: AppTextStyles.font14.copyWith(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    : BusyOverlay(
                        show: getAllCustomer.state == ViewState.Busy,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.symmetric(
                              vertical: 17, horizontal: 14),
                          decoration: BoxDecoration(
                              color: const Color(0XFFE8E8E8),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(17),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     log('${getAllCustomer.data}');
                              //   },
                              //   child: Text(''),
                              // ),
                              Column(
                                children: List.generate(
                                    getAllCustomer.data.length, (index) {
                                  final data = getAllCustomer.data[index];

                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () => nextScreen(
                                            context,
                                            CustomerDetailsPage(
                                              firstName:
                                                  '${data['first_name']}',
                                              lastName: '${data['last_name']} ',
                                              phoneNumber:
                                                  '${data['mobile_number']}',
                                              uniqueId: '${data['unique_id']}',
                                            )),
                                        contentPadding: EdgeInsets.zero,
                                        // leading: Text(
                                        //   getAllCustomer.firstName,
                                        //   style:
                                        //       AppTextStyles.font14.copyWith(
                                        //     color: AppColors.textColor,
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                        title: Text(
                                          '${getAllCustomer.firstName} ${getAllCustomer.lastName} ',
                                          style: AppTextStyles.font14.copyWith(
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${getAllCustomer.mobileNumber}',
                                          style: AppTextStyles.font16.copyWith(
                                            color: AppColors.subTextColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        trailing: const Icon(Icons.more_vert),
                                      ),
                                      //verticalSpace(5),
                                      Divider(
                                        color: AppColors.blackColor
                                            .withOpacity(0.1),
                                      )
                                    ],
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
              })
            ],
          ),
        ),
      )),
    );
  }
}
