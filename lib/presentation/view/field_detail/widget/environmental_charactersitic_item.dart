import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
                  color: AppColors.secondaryColor,
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
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 15,
            animation: true,
            arcType: ArcType.FULL,
            percent: 0.75,
            arcBackgroundColor: Colors.grey.withOpacity(0.3),
            startAngle: 270,
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Theme.of(context).primaryColor,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Now',
                  style: AppTextStyle.defaultBold(),
                ),
                const Text(
                  '75 %',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
