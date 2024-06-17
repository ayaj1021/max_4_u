import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class TransactionDetailComponent extends StatelessWidget {
  const TransactionDetailComponent({
    super.key, required this.isSuccess, required this.heading, required this.message,
  });

  final bool isSuccess;
  final String heading;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      text: heading,
                      style: AppTextStyles.font12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.green
                      ),
                      children: [
                        TextSpan(
                          text:
                              ' $message',
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
        );
  }
}
