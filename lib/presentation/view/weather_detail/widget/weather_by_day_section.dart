import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/string_helper.dart';

class WeatherByDaySection extends StatelessWidget {
  const WeatherByDaySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Row(
            children: [
              Text(
                "Next forecast",
                style: AppTextStyle.defaultBold(color: Colors.white),
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.calendar,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  7,
                  (i) => _buildWeatherByDayItem(
                    day: StringHelper.getFormattedDateWithShortMonth(
                        offsetDays: i),
                    icon: AppImage.windy,
                    temperature: "${29 + i} °C",
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildWeatherByDayItem(
      {required String day,
      required String icon,
      required String temperature}) {
    return Row(
      children: [
        const SizedBox(width: 50),
        Text(
          day,
          style: AppTextStyle.defaultBold(color: Colors.white),
        ),
        const Spacer(),
        Image.asset(
          icon,
          scale: 5,
        ),
        const Spacer(),
        Text(
          temperature,
          style: AppTextStyle.defaultBold(color: Colors.white),
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}
