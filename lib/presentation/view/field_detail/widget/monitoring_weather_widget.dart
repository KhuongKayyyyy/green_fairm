import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/data/model/weather_model.dart';
import 'package:green_fairm/presentation/view/weather_detail/weather_detail_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MonitoringWeatherWidget extends StatefulWidget {
  final WeatherModel weather;
  const MonitoringWeatherWidget({super.key, required this.weather});

  @override
  State<MonitoringWeatherWidget> createState() =>
      _MonitoringWeatherWidgetState();
}

class _MonitoringWeatherWidgetState extends State<MonitoringWeatherWidget> {
  Gemini gemini = Gemini.instance;
  String recommendation =
      "Water your plants in the morning or evening when the temperature is cooler to minimize evaporation.";
  StringBuffer fullRecommendation = StringBuffer();
  bool isLoading = true; // Flag to track loading state

  @override
  void initState() {
    super.initState();
    _fetchRecommendation();
  }

  void _fetchRecommendation() {
    setState(() {
      isLoading = true; // Start loading
    });

    gemini.promptStream(
      parts: [
        Part.text(
          "Provide a concise 15 words plant care recommendation based on this weather data: ${widget.weather}",
        ),
      ],
    ).listen((value) {
      setState(() {
        fullRecommendation.write(value?.output ?? "");
        recommendation = fullRecommendation.toString();
      });
    }).onDone(() {
      setState(() {
        isLoading = false; // Stop loading when done
      });
      if (kDebugMode) {
        print("Final Recommendation: $recommendation");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Weather",
            style: AppTextStyle.defaultBold(),
          ),
          Row(children: [_buildTemperature(), _buildFarmTip()]),
          _buildWeatherDetail(),
        ],
      ),
    );
  }

  Widget _buildTemperature() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(
            AppImage.hot_sun,
            scale: 14,
          ),
          Text(
            "${widget.weather.temperature.round()}°C",
            style: AppTextStyle.defaultBold(),
          ),
          const Text(
            'Today ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.grey),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFarmTip() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tips",
              style: AppTextStyle.defaultBold(),
            ),
            const SizedBox(height: 10),
            isLoading
                ? Skeletonizer(
                    enabled: true,
                    enableSwitchAnimation: true,
                    child: Text(
                      recommendation,
                      style: AppTextStyle.defaultBold(color: AppColors.grey),
                    ),
                  )
                : Text(
                    recommendation,
                    style: AppTextStyle.defaultBold(color: AppColors.grey),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail() {
    return InkWell(
      onTap: () {
        _showWeatherDetail(context);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("More detail", style: AppTextStyle.defaultBold()),
            const SizedBox(width: 10),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.secondaryColor,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showWeatherDetail(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const WeatherDetailPage();
        });
  }
}
