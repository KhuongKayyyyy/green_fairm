import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';

class EnvironmentalCharactersiticQualityItem extends StatelessWidget {
  String type;
  String value;
  IconData icon;
  bool isQuality;
  EnvironmentalCharactersiticQualityItem(
      {super.key,
      required this.value,
      required this.type,
      required this.icon,
      this.isQuality = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    icon,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                type,
                style: AppTextStyle.defaultBold(),
              ),
            ],
          ),
          Text(
            isQuality
                ? getAirQualityState(double.parse(value).toInt())
                : getRainIntensity(double.parse(value).toInt()),
            style: AppTextStyle.defaultBold(),
          ),
        ],
      ),
    );
  }

  String getAirQualityState(int analogValue) {
    if (analogValue <= 1000) {
      return "Good";
    } else if (analogValue <= 2000) {
      return "Moderate";
    } else if (analogValue <= 3000) {
      return "Poor";
    } else {
      return "Bad";
    }
  }

  String getRainIntensity(int analogValue) {
    if (analogValue <= 1000) {
      return "Heavy Rain";
    } else if (analogValue <= 2000) {
      return "Moderate Rain";
    } else if (analogValue <= 3000) {
      return "Light Rain";
    } else {
      return "No Rain";
    }
  }
}
