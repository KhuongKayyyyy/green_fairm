import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/widget/grey_button.dart';

class FieldInformationItem extends StatelessWidget {
  final String informationType;
  final String information;
  final bool? isExpandable;
  const FieldInformationItem(
      {super.key,
      required this.informationType,
      required this.information,
      this.isExpandable = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        gradient: informationType == "Crop health"
            ? LinearGradient(
                colors: [AppColors.primaryColor.withOpacity(0.7), Colors.white],
                end: Alignment.bottomLeft,
                begin: Alignment.topCenter,
              )
            : null,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(informationType,
              style: AppTextStyle.defaultBold(color: AppColors.secondaryColor)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  information,
                  softWrap: true,
                  style: AppTextStyle.defaultBold(
                      color: informationType == "Crop health"
                          ? AppColors.primaryColor
                          : Colors.black),
                ),
              ),
              const SizedBox(width: 8),
              isExpandable == true
                  ? GreyButton(
                      child: const Icon(CupertinoIcons.chevron_right),
                      onPressed: () {})
                  : const SizedBox(
                      height: 45,
                      width: 45,
                    )
            ],
          )
        ],
      ),
    );
  }
}
