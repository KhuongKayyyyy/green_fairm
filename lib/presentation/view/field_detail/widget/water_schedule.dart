import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/field_detail/water_statistic.dart';
import 'package:green_fairm/presentation/widget/primary_button.dart';

class WaterSchedule extends StatefulWidget {
  const WaterSchedule({super.key});

  @override
  State<WaterSchedule> createState() => _WaterScheduleState();
}

class _WaterScheduleState extends State<WaterSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Water Schedule",
              style: AppTextStyle.defaultBold(),
            ),

            // First List of Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                7,
                (index) => IconButton(
                  onPressed: () {},
                  icon: Icon(
                    index % 2 == 0 ? Icons.water_drop : Icons.circle,
                    color: AppColors.primaryColor,
                    size: index % 2 == 0 ? 25 : 15,
                  ),
                ),
              ),
            ),

            // Linear Progress Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: 3 / 7, // 3 days out of 7
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mon", style: AppTextStyle.defaultBold()),
                    Text("Tue", style: AppTextStyle.defaultBold()),
                    Text("Wed", style: AppTextStyle.defaultBold()),
                    Text("Thu", style: AppTextStyle.defaultBold()),
                    Text("Fri", style: AppTextStyle.defaultBold()),
                    Text("Sat", style: AppTextStyle.defaultBold()),
                    Text("Sun", style: AppTextStyle.defaultBold()),
                  ],
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
                text: "Check Statistic",
                onPressed: () {
                  _onCheckStatistic();
                })
          ],
        ));
  }

  void _onCheckStatistic() {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) => WaterStatistic());
  }
}
