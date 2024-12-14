import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.primaryColor,
            AppColor.secondaryColor,
          ],
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.mediumBold(),
        ),
      ),
    );
  }
}
