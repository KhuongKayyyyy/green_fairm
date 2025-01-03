import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/core/util/fake_data.dart';
import 'package:green_fairm/data/model/field.dart';
import 'package:green_fairm/data/model/realtime_sensor_data.dart';
import 'package:green_fairm/presentation/bloc/weather/weather_bloc.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/basic_characteristic.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/field_setting.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/monitoring_weather_widget.dart';
import 'package:green_fairm/presentation/view/field_detail/widget/water_history_section.dart';
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
  final WeatherBloc _weatherBloc = WeatherBloc();
  final String broker = '103.216.117.115';
  final int port = 1883;
  final String topic = 'ngoctruongbui/sensor_realtime';
  MqttServerClient? client;

  RealtimeSensorData? sensorData;
  int _slidingIndex = 0;

  @override
  void initState() {
    super.initState();
    _weatherBloc.add(WeatherGetByCity(city: _getStateOnly(widget.field.area!)));
    _connectToMqtt();
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
      print('Connecting to MQTT...');
      await client!.connect();
    } catch (e) {
      print('Error connecting to MQTT: $e');
      client!.disconnect();
      return;
    }

    if (client!.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT Connected');
      _subscribeToTopic();
    } else {
      print('Failed to connect, status: ${client!.connectionStatus}');
    }
  }

  void _subscribeToTopic() {
    client!.subscribe(topic, MqttQos.atLeastOnce);

    client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
      final MqttPublishMessage message =
          messages[0].payload as MqttPublishMessage;
      final payload =
          MqttPublishPayload.bytesToStringAsString(message.payload.message);

      print('Received message: $payload');
      try {
        final json = jsonDecode(payload);
        final newSensorData = RealtimeSensorData.fromJson(json);

        setState(() {
          sensorData = newSensorData;
        });

        print('Updated sensor data: $sensorData');
      } catch (e) {
        print('Error parsing MQTT message: $e');
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
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Failed to load weather'),
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
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          WaterUsage(),
          SizedBox(height: 20),
          WaterHistorySection(),
          SizedBox(height: 20),
          WaterSchedule(),
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
