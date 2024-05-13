import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/screens/notification/notification_details_screen.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/screen_navigator.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TransactionDetailComponent extends StatelessWidget {
  const TransactionDetailComponent({
    super.key, required this.isSuccess,
  });

  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, const NotificationDetailsScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        height: 54.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xffFDFDFD),
          border: Border.all(
            color: const Color(0xffB0D3EB),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 27.h,
              width: 27.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xff3EB7FB).withOpacity(0.2),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                size: 20,
                color: Color(0xff0072BF),
              ),
            ),
            horizontalSpace(9),
            SizedBox(
              height: 31.h,
              width: 295.w,
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                    text: 'Transaction failed. ',
                    style: AppTextStyles.font12.copyWith(
                      fontWeight: FontWeight.w500,
                      color:isSuccess ? Colors.green: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'A sum of three thousand (3,000) airtime sent to Akinbisehin N...........',
                        style: AppTextStyles.font12.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              const Color(0xff1B1A1A).withOpacity(0.5),
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
