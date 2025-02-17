import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/service/noti_service.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/model/realtime_sensor_data.dart';
import 'package:green_fairm/presentation/bloc/weather/weather_bloc.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/basic_characteristic.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_setting.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/monitoring_weather_widget.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_section.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_monitoring.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_need_prediction.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_schedule.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_usage.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FieldMonitoring extends StatefulWidget {
  final Field field;

  const FieldMonitoring({super.key, required this.field});

  @override
  State<FieldMonitoring> createState() => _FieldMonitoringState();
}

class _FieldMonitoringState extends State<FieldMonitoring> {
  bool isWatering = false;
  bool isAutomatic = false;
  bool _hasNotifiedRain = false;
  bool _hasNotifiedGas = false;
  final WeatherBloc _weatherBloc = WeatherBloc();
  final String broker = '103.216.117.115';
  final int port = 1883;
  final String topic = 'ngoctruongbui/sensor_realtime';
  String waterTopic = 'bekhuongcute/watering';

  MqttServerClient? client;

  RealtimeSensorData? sensorData;
  int _slidingIndex = 0;

  // waterHistoryBloc
  @override
  void initState() {
    super.initState();
    waterTopic = 'bekhuongcute/watering_${widget.field.id}';
    _weatherBloc.add(WeatherGetByCity(city: _getStateOnly(widget.field.area!)));
    _connectToMqtt();
  }

  void _switchIrrigationMode(bool value) {
    final switchIrrigationMode = jsonEncode({
      'isAutoWatering': value,
    });
    final builder = MqttClientPayloadBuilder();
    builder.addString(switchIrrigationMode);

    client!.publishMessage(waterTopic, MqttQos.atLeastOnce, builder.payload!);

    if (kDebugMode) {
      print('Test JSON sent: $switchIrrigationMode');
    }
  }

  void _sendWaterRequest(bool value) {
    final requestJson = jsonEncode({
      'isWatering': value,
      'remainingTime': 300,
    });

    final builder = MqttClientPayloadBuilder();
    builder.addString(requestJson);

    client!.publishMessage(waterTopic, MqttQos.atLeastOnce, builder.payload!);

    if (kDebugMode) {
      print('Test JSON sent: $requestJson');
    }
  }

  Future<void> _connectToMqtt() async {
    client = MqttServerClient(broker, '');
    client!.port = port;
    client!.logging(on: true);

    final connMessage = MqttConnectMessage()
        .withClientIdentifier('FieldMonitoringClient')
        .startClean();
    client!.connectionMessage = connMessage;

    try {
      if (kDebugMode) {
        print('Connecting to MQTT...');
      }
      await client!.connect();
    } catch (e) {
      if (kDebugMode) {
        print('Error connecting to MQTT: $e');
      }
      client!.disconnect();
      return;
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      if (kDebugMode) {
        print('MQTT Connected');
      }
      _subscribeToTopic();
    } else {
      if (kDebugMode) {
        print('Failed to connect, status: ${client!.connectionStatus}');
      }
    }
  }

  void _subscribeToTopic() {
    client!.subscribe(topic, MqttQos.atLeastOnce);

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final MqttPublishMessage message =
          messages[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      // if (kDebugMode) {
      //   print('Received message: $payload');
      // }
      try {
        final json = jsonDecode(payload);
        final newSensorData = RealtimeSensorData.fromJson(json);

        setState(() {
          sensorData = newSensorData;
        });
        double gasVolume = double.parse(newSensorData.gasVolume);

        if (gasVolume > 1200 && !_hasNotifiedGas) {
          NotiService().showNotification(
              title: "Fire Warning 🔥",
              body:
                  "A considerable amount of gas ${gasVolume.toStringAsFixed(2)} ppm found in your farm, Khuong",
              id: 2);
          _hasNotifiedGas = true; // Prevent duplicate notifications
        } else if (gasVolume <= 1200) {
          _hasNotifiedGas = false; // Reset flag when gas level is safe
        }

        double rainVolume = double.parse(newSensorData.rainVolume);

        if (rainVolume < 3000 && !_hasNotifiedRain) {
          NotiService().showNotification(
              title: "It's raining outside 🌧️",
              body: "Looks like it's raining at your farm, Khuong",
              id: 3);
          _hasNotifiedRain = true; // Prevent duplicate notifications
        } else if (rainVolume < 1500 && !_hasNotifiedRain) {
          NotiService().showNotification(
              title: "Heavy rain ⛈️",
              body: "It's raining heavily at your farm, Khuong",
              id: 3);
          _hasNotifiedRain = true; // Prevent duplicate notifications
        } else if (rainVolume > 3000) {
          _hasNotifiedRain = false; // Reset flag when rain stops
        }

        // if (kDebugMode) {
        //   print('Updated sensor data: $sensorData');
        // }
      } catch (e) {
        if (kDebugMode) {
          print('Error parsing MQTT message: $e');
        }
      }
    });
  }

  String _getStateOnly(String location) {
    final parts = location.split(', ');
    if (parts.length >= 3) {
      final state = parts[1];
      return state;
    } else {
      return "";
    }
  }

  @override
  void dispose() {
    client?.disconnect();
    super.dispose();
  }

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
            groupValue: _slidingIndex,
          ),
        ),
        if (_slidingIndex == 0) _buildMonitoring(),
        if (_slidingIndex == 1) _buildIrrigation(),
        if (_slidingIndex == 2) _buildSettings(),
      ],
    );
  }

  Widget _buildMonitoring() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          BlocBuilder<WeatherBloc, WeatherState>(
            bloc: _weatherBloc,
            builder: (context, weatherState) {
              if (weatherState is WeatherLoading) {
                return MonitoringWeatherWidget(
                  weather: FakeData.fakeWeather,
                );
              } else if (weatherState is WeatherLoaded) {
                return MonitoringWeatherWidget(
                  weather: weatherState.weather,
                );
              } else if (weatherState is WeatherError) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightbg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      "Error loading weather data",
                      style: AppTextStyle.defaultBold(color: Colors.white),
                    ),
                  ),
                );
              }
              return Skeletonizer(
                child: MonitoringWeatherWidget(weather: FakeData.fakeWeather),
              );
            },
          ),
          const SizedBox(height: 15),
          if (sensorData != null) BasicCharacteristic(sensorData: sensorData),
        ],
      ),
    );
  }

  Widget _buildIrrigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          WaterNeedPrediction(
            field: widget.field,
          ),
          WaterMonitoring(
            refresh: () => setState(() {}),
            field: widget.field,
            sensorData: sensorData,
            mqqtNotifier: _sendWaterRequest,
          ),
          const SizedBox(height: 20),
          WaterHistorySection(
            field: widget.field,
          ),
          const SizedBox(height: 20),
          const WaterUsage(),
          const SizedBox(height: 20),
          const WaterSchedule(),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          FieldSetting(
            field: widget.field,
            mqqtNotifier: _switchIrrigationMode,
          )
        ],
      ),
    );
  }
}
