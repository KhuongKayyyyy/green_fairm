import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/presentation/view/notification/notification_page.dart';

class WeatherReport extends StatefulWidget {
  const WeatherReport({super.key});

  @override
  State<WeatherReport> createState() => _WeatherReportState();
}

class _WeatherReportState extends State<WeatherReport> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLocation(),
            ],
          ),
          const SizedBox(height: 20),
          _buildWeatherInfo(),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.mediumWhite.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            CupertinoIcons.map_pin_ellipse,
            color: AppColors.secondaryColor,
          ),
          Text(
            'Thốt Nốt, Cần Thơ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.secondaryColor),
          )
        ],
      ),
    );
  }

  Widget _buildWeatherInfo() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColors.mediumWhite, Colors.white],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            AppImage.hot_sun,
            scale: 8,
          ),
          const Text(
            '32°C',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
          ),
          const Text(
            'Today is partly sunny day!',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
          ),
          const SizedBox(height: 10),
          _buildWeatherDetail(),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '77 %',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Humidity',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '0.01 in',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Precipitation',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '6 mph/s',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Wind Speed',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
