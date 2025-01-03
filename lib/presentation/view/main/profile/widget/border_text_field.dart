import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

// ignore: must_be_immutable
class BorderTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final IconData? icon;
  final IconData? suffixIcon;
  bool? obscureText;

  BorderTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    this.icon,
    this.obscureText = false,
  });

  @override
  State<BorderTextField> createState() => _BorderTextFieldState();
}

class _BorderTextFieldState extends State<BorderTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: AppTextStyle.defaultBold()),
        TextField(
          obscureText: widget.obscureText!,
          cursorColor: AppColors.secondaryColor,
          controller: widget.controller,
          style: AppTextStyle.defaultBold(),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyle.defaultBold(),
            border: InputBorder.none,
            suffixIcon: widget.icon != null
                ? InkWell(
                    onTap: () {
                      setState(() {
                        widget.obscureText = !widget.obscureText!;
                      });
                    },
                    child: Icon(
                      widget.icon,
                      color: AppColors.primaryColor,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
