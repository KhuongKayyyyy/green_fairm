import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const SecondaryButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.accentColor),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.mediumBold(),
          ),
        ),
      ),
    );
  }
}
