import 'package:flutter/material.dart';
import 'package:max_4_u/app/screens/customers_screen.dart/customer_details_page.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              const Text(
                'Customers',
                style: AppTextStyles.font18,
              ),
              verticalSpace(25),
              TextInputField(
                controller: _searchController,
                hintText: 'Search for a customer',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xff4F4F4F),
                ),
              ),
              verticalSpace(25),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(vertical: 17, horizontal: 14),
                decoration: BoxDecoration(
                    color: const Color(0XFFE8E8E8),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    verticalSpace(17),
                    SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 20,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () => nextScreen(
                                        context, const CustomerDetailsPage()),
                                    contentPadding: EdgeInsets.zero,
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/user_profile_image.png'),
                                    ),
                                    title: Text(
                                      'Peace Adedokun',
                                      style: AppTextStyles.font14.copyWith(
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '93395853348',
                                      style: AppTextStyles.font16.copyWith(
                                        color: AppColors.subTextColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: const Icon(Icons.more_vert),
                                  ),
                                  //verticalSpace(5),
                                  Divider(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                  )
                                ],
                              );
                            })),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
