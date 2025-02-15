import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotiService {
  final notificationPlugins = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones(); // Initialize timezone data

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: initSettingsIOS,
    );

    await notificationPlugins.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        if (kDebugMode) {
          print("Notification tapped!");
        }
        if (kDebugMode) {
          print(details);
        }
      },
      // ignore: avoid_print
      onDidReceiveBackgroundNotificationResponse: (details) => print(details),
    );

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Notification that appears every day at 5 AM',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  /// Schedule a daily notification at 5 AM
  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      5, // 5 AM
      0,
    );

    // If 5 AM has already passed today, schedule for tomorrow
    final nextNotificationTime = scheduledTime.isBefore(now)
        ? scheduledTime.add(const Duration(days: 1))
        : scheduledTime;

    await notificationPlugins.zonedSchedule(
      id,
      title,
      body,
      nextNotificationTime,
      notificationDetails(),
      androidScheduleMode:
          AndroidScheduleMode.exactAllowWhileIdle, // Ensures exact scheduling
      matchDateTimeComponents:
          DateTimeComponents.time, // Repeats daily at the same time
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    required int id,
  }) async {
    await notificationPlugins.show(
      id,
      title,
      body,
      notificationDetails(),
      payload: 'payload',
    );
  }
}
