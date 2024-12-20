import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? isReverse;
  const PrimaryButton(
      {super.key, required this.text, required this.onPressed, this.isReverse});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: isReverse == true
              ? null
              : const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor.primaryColor,
                    AppColor.secondaryColor,
                  ],
                ),
          color: isReverse == true ? Colors.white : null,
          border: isReverse == true
              ? Border.all(color: AppColor.secondaryColor)
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: isReverse == true
                ? AppTextStyle.mediumBold()
                    .copyWith(color: AppColor.secondaryColor)
                : AppTextStyle.mediumBold(),
          ),
        ),
      ),
    );
  }
}
