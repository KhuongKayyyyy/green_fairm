import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class EnvironmentalCharactersiticItem extends StatelessWidget {
  final IconData icon;
  final String type;
  const EnvironmentalCharactersiticItem(
      {super.key, required this.icon, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: AppColor.secondaryColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                type,
                style: AppTextStyle.defaultBold(),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Coming soon",
            style: AppTextStyle.defaultBold(color: AppColor.primaryColor),
          )
        ],
      ),
    );
  }
}
