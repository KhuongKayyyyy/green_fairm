import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class ChangePassSuccessfully extends StatelessWidget {
  const ChangePassSuccessfully({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.secondaryColor.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 5)),
                    BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.8),
                        blurRadius: 80,
                        offset: const Offset(0, 10)),
                  ],
                  gradient: const LinearGradient(colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor
                  ])),
              child: const Icon(CupertinoIcons.check_mark,
                  size: 50, color: Colors.white),
            ),
            const SizedBox(height: 50),
            Text("Password Changed Successfully",
                style:
                    AppTextStyle.mediumBold(color: AppColors.secondaryColor)),
            Text("You can now login with your new password",
                style: AppTextStyle.defaultBold(color: Colors.grey)),
            // const SizedBox(height: 300),
            const Spacer(),
            PrimaryButton(
                text: "Go To Home",
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
