import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:max_4_u/app/styles/app_text_styles.dart';
import 'package:max_4_u/app/utils/white_space.dart';

class SettingsOptionSection extends StatelessWidget {
  const SettingsOptionSection({
    super.key,
    required this.icon,
    required this.settingOption,
    this.onTap,
    required this.iconData,
    this.iconOnTap, this.iconDataColor,
  });
  final String icon;
  final IconData iconData;
  final String settingOption;
  final Color? iconDataColor;
  final Function()? onTap;
  final Function()? iconOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
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
            InkWell(
              onTap: iconOnTap,
              child: Icon(
                iconData,
                size: 15,
                color: iconDataColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
