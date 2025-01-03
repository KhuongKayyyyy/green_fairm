import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class WaterDailyUse extends StatelessWidget {
  const WaterDailyUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("January Usage",
            style: AppTextStyle.mediumBold(color: AppColors.primaryColor)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: 31,
            itemBuilder: (context, index) {
              final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
              final random = Random();
              final usagePercentage = random.nextDouble() + 0.2;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildWaterDailyUseItem(
                    days[index % 7], "${index + 1}", "15 m", usagePercentage),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWaterDailyUseItem(
      String day, String date, String usage, double usagePercentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Usage text
          Text(
            usage,
            style: AppTextStyle.smallBold(),
          ),

          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            width: 10,
            child: RotatedBox(
              quarterTurns: -1,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(10),
                value: usagePercentage,
                valueColor: AlwaysStoppedAnimation(
                    AppColors.primaryColor.withOpacity(0.5)),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),

          const SizedBox(height: 8),
          Text(
            day,
            style: AppTextStyle.smallBold(),
          ),
          Text(
            date,
            style: AppTextStyle.smallBold().copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
