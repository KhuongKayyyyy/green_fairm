// import 'package:flutter/material.dart';
// import 'package:green_fairm/data/model/realtime_sensor_data.dart';
// import 'package:green_fairm/presentation/view/field_detail/widget/basic_characteristic.dart';
// import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_server_client.dart';
// import 'dart:convert'; // For JSON parsing

// class MqttExample extends StatefulWidget {
//   const MqttExample({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MqttExampleState createState() => _MqttExampleState();
// }

// class _MqttExampleState extends State<MqttExample> {
//   final String broker = '103.216.117.115'; // Replace with your broker address
//   final int port = 1883;
//   final String topic = 'ngoctruongbui/sensor_realtime';
//   MqttServerClient? client;

//   RealtimeSensorData? sensorData;

//   @override
//   void initState() {
//     super.initState();
//     _connectToMqtt();
//   }

//   Future<void> _connectToMqtt() async {
//     client = MqttServerClient(broker, '');
//     client!.port = port;
//     client!.logging(on: true);
//     client!.onDisconnected = _onDisconnected;

//     final connMessage =
//         MqttConnectMessage().withClientIdentifier('FlutterClient').startClean();
//     client!.connectionMessage = connMessage;

//     try {
//       print('Connecting to MQTT...');
//       await client!.connect();
//     } catch (e) {
//       print('Error connecting to MQTT: $e');
//       client!.disconnect();
//     }

//     if (client!.connectionStatus!.state == MqttConnectionState.connected) {
//       print('MQTT Connected');
//       _subscribeToTopic();
//     } else {
//       print('Failed to connect, status: ${client!.connectionStatus}');
//     }
//   }

//   void _subscribeToTopic() {
//     client!.subscribe(topic, MqttQos.atLeastOnce);

//     client!.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
//       final MqttPublishMessage message =
//           messages[0].payload as MqttPublishMessage;
//       final payload =
//           MqttPublishPayload.bytesToStringAsString(message.payload.message);
//       print('Received message: $payload');
//       try {
//         final json = jsonDecode(payload);
//         final newSensorData = RealtimeSensorData.fromJson(json);

//         setState(() {
//           sensorData = newSensorData;
//         });

//         print('Received data: $newSensorData');
//       } catch (e) {
//         print('Error parsing MQTT message: $e');
//       }
//     });
//   }

//   void _onDisconnected() {
//     print('Disconnected from MQTT');
//   }

//   @override
//   void dispose() {
//     client?.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('MQTT Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             BasicCharacteristic(sensorData: sensorData),
//           ],
//         ),
//       ),
//     );
//   }
// }
