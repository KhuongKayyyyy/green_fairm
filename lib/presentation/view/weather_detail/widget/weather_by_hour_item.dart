import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_image.dart';

class WeatherByHourItem extends StatelessWidget {
  final DateTime time;
  const WeatherByHourItem({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    // Get the current time without minutes and seconds for comparison
    DateTime currentTime = DateTime.now();
    bool isCurrentTime =
        currentTime.hour == time.hour && currentTime.day == time.day;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentTime
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "29 °C",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                AppImage.windy,
                scale: 5,
              ),
              Text(
                "${time.hour.toString().padLeft(2, '0')}:00",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
