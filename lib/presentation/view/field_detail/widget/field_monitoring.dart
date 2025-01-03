import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/basic_characteristic.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_setting.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/monitoring_weather_widget.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_section.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_schedule.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_usage.dart';

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
              thumbColor: AppColors.primaryColor.withOpacity(0.5),
              children: {
                0: Text(
                  "Monitoring",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 0
                          ? AppColors.secondaryColor
                          : Colors.grey),
                ),
                1: Text(
                  "Irrigation",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 1
                          ? AppColors.secondaryColor
                          : Colors.grey),
                ),
                2: Text(
                  "Settings",
                  style: AppTextStyle.defaultBold(
                      color: _slidingIndex == 2
                          ? AppColors.secondaryColor
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
        if (_slidingIndex == 1) _buildIrrigation(),
        if (_slidingIndex == 2) _buildSettings()
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

  Widget _buildIrrigation() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          WaterUsage(),
          SizedBox(
            height: 20,
          ),
          WaterHistorySection(),
          SizedBox(
            height: 20,
          ),
          WaterSchedule()
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [FieldSetting()],
      ),
    );
  }
}
