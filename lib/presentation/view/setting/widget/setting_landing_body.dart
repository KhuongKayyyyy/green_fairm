import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_setting.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/router/routes.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class SettingLandingBody extends StatelessWidget {
  const SettingLandingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Let's start your journey with Green Fairm",
          textAlign: TextAlign.center,
          style: AppTextStyle.largeBold(color: AppColors.secondaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          "Create an account to access Green Fairm , and start set up your farm and garden",
          style: AppTextStyle.defaultBold(color: AppColors.secondaryColor),
        ),
        const SizedBox(height: 70),
        PrimaryButton(
            text: "Get started",
            onPressed: () {
              context.pushNamed(Routes.settingDetail);
            }),
        const SizedBox(height: 20),
        PrimaryButton(
          text: "Set up later",
          onPressed: () {
            context.goNamed(Routes.home);
          },
          isReverse: true,
        ),
      ],
    );
  }
}
