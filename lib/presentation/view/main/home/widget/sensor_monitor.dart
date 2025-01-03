import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SensorMonitor extends StatefulWidget {
  const SensorMonitor({super.key});

  @override
  State<SensorMonitor> createState() => _SensorMonitorState();
}

class _SensorMonitorState extends State<SensorMonitor> {
  static const _backgroundColor = Color(0xFFF15BB5);

  final _onlineColor = [
    AppColors.primaryColor,
    AppColors.secondaryColor.withOpacity(0.5),
  ];
  static const _lowBatterColor = [
    Color.fromARGB(255, 115, 206, 236),
    Color(0xFF00BBF9),
  ];
  static const _offlineColor = [
    Color.fromARGB(255, 226, 138, 30),
    Color.fromARGB(255, 238, 15, 15),
  ];

  static const _durations = [
    5000,
    4000,
  ];

  static const _lowBatteryDuration = [
    6000,
    7000,
  ];
  static const _offlineDuration = [
    8000,
    9000,
  ];

  static const _heightPercentages = [
    0.65,
    0.66,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Sensor Monitor",
                style: AppTextStyle.defaultBold(),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Text("View All",
                    style:
                        AppTextStyle.smallBold(color: AppColors.primaryColor)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildSensorMonitorItem(
                    _onlineColor,
                    AppColors.primaryColor.withOpacity(0.5),
                    _durations,
                    "online",
                    "135"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSensorMonitorItem(
                    _lowBatterColor,
                    Colors.lightBlue[100]!,
                    _lowBatteryDuration,
                    "low battery",
                    "15"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildSensorMonitorItem(_offlineColor, Colors.red[100]!,
                    _offlineDuration, "offline", "5"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSensorMonitorItem(
    List<Color> colors,
    Color backgroundColor,
    List<int> durations,
    String title,
    String value,
  ) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: WaveWidget(
            config: CustomConfig(
              colors: colors,
              durations: durations,
              heightPercentages: _heightPercentages,
            ),
            backgroundColor: backgroundColor,
            size: Size(MediaQuery.of(context).size.height * 0.25,
                MediaQuery.of(context).size.width * 0.25),
            waveAmplitude: 0,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                value,
                style: AppTextStyle.defaultBold(),
              ),
              Text(
                title,
                style: AppTextStyle.defaultBold(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
