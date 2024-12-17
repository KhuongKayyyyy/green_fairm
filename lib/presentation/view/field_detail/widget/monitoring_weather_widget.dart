import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/weather_detail/weather_detail_page.dart';

class MonitoringWeatherWidget extends StatefulWidget {
  const MonitoringWeatherWidget({super.key});

  @override
  State<MonitoringWeatherWidget> createState() =>
      _MonitoringWeatherWidgetState();
}

class _MonitoringWeatherWidgetState extends State<MonitoringWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [AppColor.mediumWhite, Colors.white],
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
            '32°C',
            style: AppTextStyle.defaultBold(),
          ),
          const Text(
            'Today ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColor.grey),
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
            Text(
              "Water your plants in the morning or evening when the temperature is cooler to minimize evaporation.",
              style: AppTextStyle.defaultBold(color: AppColor.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail() {
    return InkWell(
      onTap: () {
        // context.pushNamed(Routes.weatherDetail);
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
              color: AppColor.secondaryColor,
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
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(
        //     top: Radius.circular(16),
        //   ),
        // ),
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return const WeatherDetailPage();
        });
  }
}
