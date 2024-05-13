import 'package:flutter/material.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class SettingsOptionSection extends StatelessWidget {
  const SettingsOptionSection({
    super.key,
    required this.icon,
    required this.settingOption,
    this.onTap,
  });
  final String icon;
  final String settingOption;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          SizedBox(height: 24, width: 24, child: Image.asset(icon)),
          horizontalSpace(10),
          Text(
            settingOption,
            style: AppTextStyles.font14.copyWith(
              color: const Color(0xff4F4F4F),
              fontWeight: FontWeight.w400,
            ),
          )
        ]),
        GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        )
      ],
    );
  }
}
