// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/data/model/weather_model.dart';
import 'package:green_fairm/presentation/view/main/home/widget/check_our_ai_recommendation.dart';

class WeatherReport extends StatefulWidget {
  final WeatherModel weather;
  const WeatherReport({super.key, required this.weather});

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
          const SizedBox(height: 20),
          CheckOurAiRecommendation(),
          const SizedBox(height: 20),
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
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.map_pin_ellipse,
            color: AppColors.secondaryColor,
          ),
          Text(
            widget.weather.cityName,
            style: const TextStyle(
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
          Text(
            '${widget.weather.temperature.toStringAsFixed(0)}°C',
            style: const TextStyle(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                '${widget.weather.humidity}%',
                style: const TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
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
                widget.weather.visibility,
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Visibility',
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
                '${widget.weather.windSpeed} m/s',
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
