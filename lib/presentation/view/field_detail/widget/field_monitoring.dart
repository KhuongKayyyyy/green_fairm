import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/basic_characteristic.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/monitoring_weather_widget.dart';

class FieldMonitoring extends StatefulWidget {
  const FieldMonitoring({super.key});

  @override
  State<FieldMonitoring> createState() => _FieldMonitoringState();
}

class _FieldMonitoringState extends State<FieldMonitoring> {
  int _slidingIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildSlidingSegment()],
    );
  }

  Widget _buildSlidingSegment() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl(
              thumbColor: AppColor.primaryColor.withOpacity(0.5),
              children: {
                0: Text(
                  "Monitoring",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 0
                          ? AppColor.secondaryColor
                          : Colors.grey),
                ),
                1: Text(
                  "Irrigation",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 1
                          ? AppColor.secondaryColor
                          : Colors.grey),
                ),
                2: Text(
                  "Settings",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 2
                          ? AppColor.secondaryColor
                          : Colors.grey),
                ),
              },
              onValueChanged: (value) {
                setState(() {
                  _slidingIndex = value!;
                });
              },
              groupValue: _slidingIndex),
        ),
        if (_slidingIndex == 0) _buildMonitoring(),
      ],
    );
  }

  Widget _buildMonitoring() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          MonitoringWeatherWidget(),
          SizedBox(
            height: 15,
          ),
          BasicCharacteristic()
        ],
      ),
    );
  }
}
