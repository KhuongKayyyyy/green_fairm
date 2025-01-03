import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/line_chart.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_daily_use.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_usage.dart';

class WaterStatistic extends StatefulWidget {
  const WaterStatistic({super.key});

  @override
  State<WaterStatistic> createState() => _WaterStatisticState();
}

class _WaterStatisticState extends State<WaterStatistic> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          _buildStatisticHeader(),
          const SizedBox(height: 20),
          const WaterUsageLineChart(),
          const SizedBox(height: 20),
          const WaterUsage(
            date: "January Usage",
          ),
          const SizedBox(height: 20),
          const WaterDailyUse()
        ],
      ),
    );
  }

  Row _buildStatisticHeader() {
    return Row(
      children: [
        Text(
          "Water Statistic",
          style: AppTextStyle.mediumBold(color: AppColors.secondaryColor),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            context.pop();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              "Done",
              style: AppTextStyle.defaultBold(color: AppColors.primaryColor),
            ),
          ),
        )
      ],
    );
  }
}
