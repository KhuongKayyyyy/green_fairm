import 'package:flutter/material.dart';
import 'package:green_fairm/presentation/view/weather_detail/widget/weather_by_hour_item.dart';

class WeatherByHourSection extends StatelessWidget {
  const WeatherByHourSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      width: double.infinity,
      child: Center(
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // Calculate the time for each hour based on the current time
            DateTime currentTime = DateTime.now().add(Duration(hours: index));
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: WeatherByHourItem(time: currentTime),
            );
          },
        ),
      ),
    );
  }
}
