import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class AccountSettingSection extends StatelessWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Icon icon;
  final String settingType;
  const AccountSettingSection(
      {super.key,
      this.onTap,
      required this.backgroundColor,
      required this.icon,
      required this.settingType});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundColor,
            ),
            child: icon,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            settingType,
            style: AppTextStyle.defaultBold(),
          ),
          const Spacer(),
          const Icon(CupertinoIcons.chevron_forward),
        ],
      ),
    );
  }
}
