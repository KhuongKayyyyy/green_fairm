import 'package:flutter/cupertino.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/helper.dart';
import 'package:green_fairm/data/model/realtime_sensor_data.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/environmental_charactersitic_item.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/environmental_charactersitic_quality_item.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/temperature_monitoring.dart';

class BasicCharacteristic extends StatelessWidget {
  final RealtimeSensorData? sensorData;

  const BasicCharacteristic({super.key, required this.sensorData});

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
        Row(
          children: [
            Expanded(
              child: EnvironmentalCharactersiticItem(
                icon: CupertinoIcons.drop_triangle,
                type: "Humidity",
                value: sensorData?.humidity ?? 'N/A',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: EnvironmentalCharactersiticItem(
                  icon: CupertinoIcons.tree,
                  type: "Soil moisture",
                  value: Helper.scaleToPercentageNum(
                          double.tryParse(sensorData!.soilMoisture.toString())
                                  ?.toInt() ??
                              0,
                          0,
                          4095)
                      .toString()),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: EnvironmentalCharactersiticQualityItem(
                  icon: CupertinoIcons.wind,
                  value: sensorData?.gasVolume ?? "N/A",
                  type: "Gas volume"),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: EnvironmentalCharactersiticQualityItem(
                  isQuality: false,
                  icon: CupertinoIcons.cloud_rain,
                  value: sensorData?.rainVolume ?? "N/A",
                  type: "Rain volume"),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        TemperatureMonitoring(
          currentTemperature:
              sensorData != null ? double.parse(sensorData!.temperature) : 0.0,
        ),
      ],
    );
  }
}
