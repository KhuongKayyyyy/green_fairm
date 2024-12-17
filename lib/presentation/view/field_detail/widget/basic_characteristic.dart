import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/environmental_charactersitic_item.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/temperature_monitoring.dart';

class BasicCharacteristic extends StatelessWidget {
  const BasicCharacteristic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic Characteristic",
          style: AppTextStyle.defaultBold(),
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          children: [
            Expanded(
              child: EnvironmentalCharactersiticItem(
                  icon: Icons.health_and_safety, type: "Nutrient"),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: EnvironmentalCharactersiticItem(
                  icon: CupertinoIcons.tree, type: "Soil"),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const TemperatureMonitoring(
          currentTemperature: 28,
        ),
      ],
    );
  }
}
