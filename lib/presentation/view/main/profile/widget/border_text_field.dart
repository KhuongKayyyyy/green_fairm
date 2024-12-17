import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class BorderTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool? obscureText;
  const BorderTextField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextStyle.defaultBold()),
        TextField(
          obscureText: obscureText!,
          cursorColor: AppColor.secondaryColor,
          controller: TextEditingController(text: hintText),
          style: TextStyle(
            color: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return AppColor.secondaryColor;
              }
              return AppColor.grey;
            }),
          ),
          decoration: InputDecoration(
            hintStyle: AppTextStyle.defaultBold(),
            border: InputBorder.none,
            suffixIcon: Icon(icon),
            suffixIconColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.focused)) {
                return AppColor.secondaryColor;
              }
              return AppColor.grey;
            }),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColor.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
