import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/environmental_data.dart';
import 'package:green_fairm/presentation/view/field_analysis/widget/data_list_item.dart';

class DataList extends StatelessWidget {
  final List<EnvironmentalData> environmentalData;

  DataList({super.key, required this.environmentalData});

  final List<String> dataTitle = [
    'Humidity',
    'Light',
    'Soil Moisture',
    'CO2',
    'Rain',
  ];

  final List<IconData> dataIcon = [
    Icons.ac_unit,
    Icons.lightbulb,
    Icons.water,
    Icons.cloud,
    Icons.wb_sunny,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          "Detail information",
          style: AppTextStyle.defaultBold(),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: dataTitle.length,
                    itemBuilder: (context, index) {
                      // Get the data value dynamically based on the index
                      final dataValue = _getEnvironmentalValue(
                          environmentalData.first, index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DataListItem(
                          icon: dataIcon[index],
                          title: dataTitle[index],
                          data: dataValue,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to map the correct data value based on the index
  num _getEnvironmentalValue(EnvironmentalData data, int index) {
    switch (index) {
      case 0:
        return data.humidity ?? 0;
      case 1:
        return data.light ?? 0;
      case 2:
        return data.soilMoisture ?? 0;
      case 3:
        return data.co2 ?? 0;
      case 4:
        return data.rain ?? 0;
      default:
        return 0;
    }
  }
}
