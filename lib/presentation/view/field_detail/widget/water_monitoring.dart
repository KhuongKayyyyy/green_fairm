import 'dart:async';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/service/noti_service.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/model/realtime_sensor_data.dart';
import 'package:green_fairm/data/model/water_history.dart';
import 'package:green_fairm/data/res/water_history_repository.dart';

// ignore: must_be_immutable
class WaterMonitoring extends StatefulWidget {
  VoidCallback? refresh;
  Field field;
  RealtimeSensorData? sensorData;
  Function(bool)? mqqtNotifier;
  WaterMonitoring(
      {super.key,
      this.sensorData,
      this.mqqtNotifier,
      required this.field,
      this.refresh});

  @override
  State<WaterMonitoring> createState() => _WaterMonitoringState();
}

class _WaterMonitoringState extends State<WaterMonitoring> {
  Duration _duration = Duration.zero;
  Timer? _timer;
  BaseUnit _baseUnit = BaseUnit.second;
  DateTime? _startTime;
  Duration? _elapsedTime;
  WaterHistory _waterHistory = WaterHistory();

  @override
  void initState() {
    super.initState();
    _waterHistory.fieldId = widget.field.id;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      } else {
        _stopWatering();
      }
    });
  }

  void _startWatering() {
    widget.mqqtNotifier!(true);
    setState(() {
      widget.sensorData?.isWatering = true;
      _startTime = DateTime.now();
      _elapsedTime = null;

      // Set startDate in WaterHistory
      _waterHistory.startDate = _startTime!.toLocal().toIso8601String();
      _waterHistory.endDate = null; // Reset endDate when starting
    });

    if (_duration.inSeconds > 0) {
      _startTimer();
    }
  }

  void _stopWatering() {
    _timer?.cancel();
    widget.mqqtNotifier!(false);
    setState(() {
      widget.sensorData?.isWatering = false;
      if (_startTime != null) {
        _elapsedTime = DateTime.now().difference(_startTime!);
      }
      _duration = Duration.zero;

      // Set endDate in WaterHistory and save
      _waterHistory.endDate = DateTime.now().toLocal().toIso8601String();
      _saveWaterHistory();
      widget.refresh!.call();
      _startTime = null;
    });

    NotiService().showNotification(
        title: "Watering completed 💦",
        body:
            "Irrigating process is done at ${widget.field.name} in ${calculateTimeDifference(_waterHistory.startDate!, _waterHistory.endDate!)}, Khuong!",
        id: 3);
  }

  String calculateTimeDifference(String start, String end) {
    DateTime startTime = DateTime.parse(start).toLocal();
    DateTime endTime = DateTime.parse(end).toLocal();

    Duration difference = endTime.difference(startTime);

    if (difference.inHours > 0) {
      return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m ${difference.inSeconds.remainder(60)}s';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ${difference.inSeconds.remainder(60)}s';
    } else {
      return '${difference.inSeconds}s';
    }
  }

  void _saveWaterHistory() {
    // Ensure startDate is set before saving
    if (_waterHistory.startDate != null && _waterHistory.endDate != null) {
      _waterHistory.createdAt = DateTime.now().toLocal().toIso8601String();
      WaterHistoryRepository().addWaterHistory(_waterHistory);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      widget.sensorData?.isWatering == true
                          ? "Watering right now"
                          : "Not watering",
                      key: ValueKey<bool>(
                          widget.sensorData?.isWatering ?? false),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "Water Monitoring",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "Second", label: "Second"),
                  DropdownMenuEntry(value: "Minute", label: "Minute"),
                  DropdownMenuEntry(value: "Hour", label: "Hour"),
                ],
                initialSelection: "Second",
                onSelected: (String? newValue) {
                  setState(() {
                    switch (newValue) {
                      case "Second":
                        _baseUnit = BaseUnit.second;
                        break;
                      case "Minute":
                        _baseUnit = BaseUnit.minute;
                        break;
                      case "Hour":
                        _baseUnit = BaseUnit.hour;
                        break;
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          DurationPicker(
            baseUnit: _baseUnit,
            duration: _duration,
            onChange: (value) {
              setState(() {
                _duration = value;
              });
            },
          ),
          Text(
            _duration == Duration.zero && _elapsedTime != null
                ? "Elapsed time: ${_elapsedTime!.inHours}h ${_elapsedTime!.inMinutes.remainder(60)}m ${_elapsedTime!.inSeconds.remainder(60)}s"
                : "Remaining time: ${_duration.inHours}h ${_duration.inMinutes.remainder(60)}m ${_duration.inSeconds.remainder(60)}s",
            style: AppTextStyle.defaultBold(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              if (widget.sensorData?.isWatering == false) {
                // widget.mqqtNotifier!(true);
                // setState(() {
                //   widget.sensorData?.isWatering = true;
                //   _startTime = DateTime.now();
                //   _elapsedTime = null;
                // });

                // if (_duration.inSeconds > 0) {
                //   _startTimer();
                // }
                _startWatering();
              } else {
                _stopWatering();
              }
            },
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    widget.sensorData?.isWatering == true
                        ? "Turn off"
                        : "Water",
                    key: ValueKey<bool>(widget.sensorData?.isWatering ?? false),
                    style: AppTextStyle.mediumBold(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
