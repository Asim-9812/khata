

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:khata_app/features/reminder/model/reminder_model.dart';
import 'package:timezone/standalone.dart' as tz;

class NotificationServices{

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings = const AndroidInitializationSettings('logo');


  void initializeNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(android: _androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(String body, {required int id, required String title,}) async {
    AndroidNotificationDetails androidNotificationDetails =
     const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);
  }

  void scheduleNotification(ReminderModel reminderModel) async {
    TimeOfDay time = reminderModel.timeOfDay;
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
        priority: Priority.max,
    );

    var now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        reminderModel.id,
        reminderModel.title,
        reminderModel.description ?? "",
        reminderModel.repeat ? _scheduleDaily(reminderModel.timeOfDay) : tz.TZDateTime.from(scheduledDate, tz.getLocation('Asia/Kathmandu')),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime
    );
  }

  static tz.TZDateTime _scheduleDaily(TimeOfDay time){
    var now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    return scheduledDate.isBefore(now) ? tz.TZDateTime.from(scheduledDate.add(const Duration(days: 1)), tz.getLocation('Asia/Kathmandu'))
        : tz.TZDateTime.from(scheduledDate, tz.getLocation('Asia/Kathmandu'));

  }

}