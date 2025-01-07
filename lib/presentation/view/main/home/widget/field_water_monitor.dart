import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/main/home/widget/field_water_pie_chart.dart';

class FieldWaterMonitor extends StatefulWidget {
  const FieldWaterMonitor({super.key});

  @override
  State<FieldWaterMonitor> createState() => _FieldWaterMonitorState();
}

class _FieldWaterMonitorState extends State<FieldWaterMonitor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      child: Column(
        children: [
          Text(
            "Field Water Monitor",
            style: AppTextStyle.defaultBold(),
          ),
          const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _buildLineChart("Low", 12, AppColor.primaryColor),
          //     _buildLineChart("Optimal", 18, AppColor.secondaryColor),
          //     _buildLineChart("Optimal", 42, AppColor.secondaryColor),
          //   ],
          // )
          const WaterPieChartWidget(),
        ],
      ),
    );
  }
}
