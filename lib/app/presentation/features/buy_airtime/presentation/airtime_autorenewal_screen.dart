import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:max_4_u/app/enums/network_dropdown.dart';
import 'package:max_4_u/app/presentation/features/buy_airtime/presentation/airtime_autorenewal_confirmation_screen.dart';
import 'package:max_4_u/app/provider/activate_auto_renewal_provider.dart';
import 'package:max_4_u/app/styles/app_colors.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/show_message.dart';
import 'package:max_4_u/app/utils/white_space.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/button_widget.dart';
import 'package:max_4_u/app/presentation/general_widgets/widgets/validity_date_widget.dart';
import 'package:provider/provider.dart';

class AirtimeAutoRenewalScreen extends StatefulWidget {
  const AirtimeAutoRenewalScreen(
      {super.key,
      required this.amount,
      required this.phoneNumber,
      required this.productCodes});
  final String amount;
  final String phoneNumber;
  final String productCodes;

  @override
  State<AirtimeAutoRenewalScreen> createState() =>
      _AirtimeAutoRenewalScreenState();
}

class _AirtimeAutoRenewalScreenState extends State<AirtimeAutoRenewalScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      DateTime now = DateTime.now();
      DateTime pickedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        now.hour,
        now.minute + 1, // Add one minute to the current time
      );

      setState(() {
        if (isStartDate) {
          _startDate = pickedDateTime;
          // Ensure end date is after start date
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = pickedDateTime;
        }
      });
    }
  }

  String _selectedValidity = dataValidityProvider[0];
  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    return Consumer<ActivateAutoRenewalProvider>(
        builder: (context, activateRenewal, _) {
      return Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Auto-Renewal',
                    style: AppTextStyles.font18,
                  ),
                ],
              ),
              verticalSpace(15),
              Center(
                child: Text(
                  'Please select next auto renewal date',
                  style: AppTextStyles.font14,
                ),
              ),
              verticalSpace(50),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // verticalSpace(24),
                      Text(
                        'Frequency',
                        style: AppTextStyles.font14.copyWith(
                          color: const Color(0xff475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      verticalSpace(4),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 52.h,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xffCBD5E1),
                          ),
                        ),
                        child: DropdownMenu(
                          hintText: _selectedValidity.toUpperCase(),
                          width: 330.w,
                          enableFilter: true,
                          enableSearch: false,
                          inputDecorationTheme: InputDecorationTheme(
                            fillColor: AppColors.whiteColor,
                            border: InputBorder.none,
                          ),
                          onSelected: (newValue) {
                            setState(() {
                              _selectedValidity = newValue!;
                            });
                          },
                          dropdownMenuEntries:
                              dataValidityProvider.map((String dataValidity) {
                            return DropdownMenuEntry(
                              value: dataValidity,
                              label: dataValidity.toUpperCase(),
                            );
                          }).toList(),
                        ),
                      ),

                      verticalSpace(32),
                      ValidityDateWidget(
                        onTap: () => _selectDate(context, true),
                        date:
                            '${_startDate != null ? dateFormat.format(_startDate!) : 'DD-MM-YY'}',
                        dateLabel: 'Start Date',
                      ),
                      verticalSpace(32),
                      ValidityDateWidget(
                        onTap: () => _selectDate(context, false),
                        date:
                            '${_endDate != null ? dateFormat.format(_endDate!) : 'DD-MM-YY'}',
                        dateLabel: 'End Date',
                      ),
                    ],
                  )
                ],
              ),
              verticalSpace(52),
              ButtonWidget(
                  onTap: () async {
                    await activateRenewal.activateAutoRenewal(
                      phoneNumber: widget.phoneNumber,
                      productCode: widget.productCodes,
                      amount: widget.amount,
                      startDate: dateFormat.format(_startDate!),
                      endDate: dateFormat.format(_endDate!),
                      intervalDaily: _selectedValidity.toLowerCase(),
                    );

                    if (activateRenewal.status == false && context.mounted) {
                      showMessage(context, activateRenewal.errorMessage,
                          isError: true);

                      debugPrint(activateRenewal.message.toString());
                      return;
                    }
                    if (activateRenewal.status == true && context.mounted) {
                      showMessage(context, activateRenewal.message,
                          isError: false);

                      nextScreen(
                          context, AirtimeAutoRenewalConfirmationScreen());
                    }
                  },
                  text: 'Set Auto Renewal')
            ],
          ),
        )),
      );
    });
  }
}
