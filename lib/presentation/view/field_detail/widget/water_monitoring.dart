import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/realtime_sensor_data.dart';

// ignore: must_be_immutable
class WaterMonitoring extends StatefulWidget {
  RealtimeSensorData? sensorData;
  Function(bool)? mqqtNotifier;
  WaterMonitoring({super.key, this.sensorData, this.mqqtNotifier});

  @override
  State<WaterMonitoring> createState() => _WaterMonitoringState();
}

class _WaterMonitoringState extends State<WaterMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Water Monitoring",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  widget.sensorData?.isWatering == true
                      ? "Watering right now"
                      : "Not watering",
                  key: ValueKey<bool>(widget.sensorData?.isWatering ?? false),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor),
            onPressed: () {
              widget.mqqtNotifier!(!(widget.sensorData?.isWatering ?? false));
              setState(() {
                widget.sensorData?.isWatering =
                    !(widget.sensorData?.isWatering ?? false);
              });
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: Text(
                widget.sensorData?.isWatering == true ? "Turn off" : "Water",
                key: ValueKey<bool>(widget.sensorData?.isWatering ?? false),
                style: AppTextStyle.defaultBold(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
