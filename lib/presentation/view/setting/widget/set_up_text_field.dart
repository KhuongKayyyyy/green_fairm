import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class SetUpTextField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String hintText;
  const SetUpTextField(
      {super.key,
      required this.title,
      required this.hintText,
      this.onChanged,
      this.controller});

  @override
  State<SetUpTextField> createState() => _SetUpTextFieldState();
}

class _SetUpTextFieldState extends State<SetUpTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyle.defaultBold()),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            cursorColor: AppColors.secondaryColor,
            style: AppTextStyle.defaultBold(),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
              hintText: widget.hintText,
            ),
          ),
        ),
      ],
    );
  }
}
