import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/water_history.dart';

class WaterHistoryItem extends StatelessWidget {
  final WaterHistory waterHistory;
  const WaterHistoryItem({super.key, required this.waterHistory});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: const Icon(
              Icons.opacity,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                waterHistory.date!,
                style: AppTextStyle.defaultBold(),
              ),
              Text(
                waterHistory.time!,
                style: AppTextStyle.smallBold(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            waterHistory.status.toString(),
            style: AppTextStyle.defaultBold(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
