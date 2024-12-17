import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/presentation/view/weather_detail/widget/current_weather_information.dart';
import 'package:green_fairm/presentation/view/weather_detail/widget/weather_by_day_section.dart';
import 'package:green_fairm/presentation/view/weather_detail/widget/weather_by_hour_section.dart';

class WeatherDetailPage extends StatelessWidget {
  const WeatherDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    int currentHour = DateTime.now().hour;

    bool isDayTime = currentHour >= 6 && currentHour < 18;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDayTime
              ? [
                  AppColor.white,
                  AppColor.primaryColor
                ] // Day gradient (white and primary)
              : [
                  AppColor.primaryColor,
                  AppColor.secondaryColor
                ], // Night gradient (primary and secondary)
        ),
      ),
      child: Stack(
        children: [
          isDayTime
              ? Positioned(
                  top: 50,
                  right: -100,
                  child: Image.asset(AppImage.sun_back, width: 200),
                )
              : Positioned(
                  top: 50,
                  right: -50,
                  child: Image.asset(AppImage.moon_back, width: 200),
                ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: ActionButtonIcon(
                //     icon: CupertinoIcons.arrow_down,
                //     onPressed: () {
                //       context.pop();
                //     },
                //   ),
                // ),
                const SizedBox(height: 20),
                Image.asset(AppImage.windy, width: 100, height: 100),
                // _buildCurrentWeatherInfo(context),
                const CurrentWeatherInformation(),
                const SizedBox(height: 20),
                const WeatherByHourSection(),
                const SizedBox(height: 20),

                const WeatherByDaySection()
              ],
            ),
          ),
          isDayTime
              ? Positioned(
                  top: 320,
                  left: -50,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Image.asset(AppImage.cloud, width: 200),
                  ),
                )
              : Positioned(
                  top: 320,
                  left: -50,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Image.asset(AppImage.star_back, width: 200),
                  ),
                ),
        ],
      ),
    );
  }
}
