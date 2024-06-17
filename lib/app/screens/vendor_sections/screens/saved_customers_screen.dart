import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/enums/view_state_enum.dart';
import 'package:max_4_u/app/provider/get_all_customers_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/busy_overlay.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/widgets/text_input_field.dart';
import 'package:provider/provider.dart';

class SavedCustomersScreen extends StatefulWidget {
  const SavedCustomersScreen({super.key});

  @override
  State<SavedCustomersScreen> createState() => _SavedCustomersScreenState();
}

class _SavedCustomersScreenState extends State<SavedCustomersScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAllCustomersProvider>(
      builder: (context, getAllCustomer, _) {
        return BusyOverlay(
          show: getAllCustomer.state == ViewState.Busy,
          title: 'loading',
          child: Scaffold(
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 41),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      horizontalSpace(104),
                       Text(
                        'Customers',
                        style: AppTextStyles.font18,
                      ),
                    ],
                  ),
                  verticalSpace(24),
                  TextInputField(
                    controller: _searchController,
                    hintText: 'Enter customer’s name or phone number',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                  verticalSpace(getAllCustomer.data.isEmpty ? 220 : 38),
                  getAllCustomer.data.isEmpty
                      ? Center(
                          child: Column(
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
                                'You have no customers yet',
                                style: AppTextStyles.font14.copyWith(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: getAllCustomer.data.length,
                              itemBuilder: (_, index) {
                                return Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Peace Adedokun',
                                        style: AppTextStyles.font14.copyWith(
                                            color: AppColors.textColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      verticalSpace(4),
                                       Text(
                                        '93395853348',
                                        style: AppTextStyles.font18,
                                      ),
                                      verticalSpace(16)
                                    ],
                                  ),
                                );
                              }),
                        )
                ],
              ),
            )),
          ),
        );
      },
    );
  }
}
