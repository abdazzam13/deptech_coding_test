import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showNotification({
    required var id,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fLN,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel-id$id', 'channel_name$id',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );
    print("id $id");
    await fLN.show(id, title, body, notificationDetails);
  }

  static Future showScheduleNotification({
    required var id,
    required String title,
    required String body,
    required DateTime scheduleTime,
    var payload,
    required FlutterLocalNotificationsPlugin fLN,
  }) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id$id', 'channel_name$id',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: const DarwinNotificationDetails(),
    );
    print("id $id");
    await fLN.zonedSchedule(
        id, title, body, _scheduleDaily(scheduleTime), notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  static tz.TZDateTime _scheduleDaily(DateTime time) {
    print("local: ${tz.local}");
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
        now.day, time.hour, time.minute, time.second);
    return scheduledDate;
  }
}
