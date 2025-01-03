import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/setting/widget/toggle_selection_item.dart';

class FieldSetting extends StatefulWidget {
  const FieldSetting({super.key});

  @override
  State<FieldSetting> createState() => _FieldSettingState();
}

class _FieldSettingState extends State<FieldSetting> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ToggleSelectionItem(
            isSelected: true,
            title: "Weather APIs",
            description:
                "Integrate weather APIs to get the most accurate weather forecast for your farm"),
        const SizedBox(height: 10),
        ToggleSelectionItem(
            title: "Environmental Sensors",
            description:
                "Soil sensors and analysis tools offer precise details on soil health factors like moisture, nutrients, pH and compaction."),
        const SizedBox(height: 10),
        ToggleSelectionItem(
            isSelected: true,
            title: "Irrigation Automation",
            description:
                "Automate irrigation systems to ensure that your crops are watered at the right time and in the right amount."),
      ],
    );
  }
}
