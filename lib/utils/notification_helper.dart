import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit/models/reminder_notification.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const CHANNEL_NAME = "Habit";
const CHANNEL_DESCRIPTION =
    "Notification that reminds you daily of the habit that you are trying to pickup.";
const CHANNEL_ID = '0';
const APP_ICON_PATH = '@mipmap/ic_launcher';

class NotificationHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static NotificationAppLaunchDetails notificationAppLaunchDetails;

  static final BehaviorSubject<ReminderNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReminderNotification>();

  static final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  static Future<void> initNotifications() async {
    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    var initializationSettingsAndroid =
        AndroidInitializationSettings(APP_ICON_PATH);
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReminderNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  static Future<void> showNotification(
      int id, String title, String body, String payload) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        CHANNEL_ID, CHANNEL_NAME, CHANNEL_DESCRIPTION,
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  static Future<void> turnOffNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<void> turnOffNotificationById(num id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

//needs configureTimeZone() to run in main
  static Future<void> scheduleNotification(int id, String title, String body,
      DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_ID,
      CHANNEL_DESCRIPTION,
      icon: APP_ICON_PATH,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        scheduledNotificationDateTime, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

//needs configureTimeZone() to run in main
  static Future<void> scheduleNotificationPeriodically(
      int id, String title, String body, RepeatInterval interval) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      CHANNEL_ID,
      CHANNEL_NAME,
      CHANNEL_DESCRIPTION,
      icon: APP_ICON_PATH,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        id, title, body, interval, platformChannelSpecifics);
  }

  static void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

//causes error
  static Future<void> configureLocalTimeZone() async {
    const MethodChannel platform =
        MethodChannel('dexterx.dev/flutter_local_notifications_example');
    tz.initializeTimeZones();
    final String timeZoneName = await platform.invokeMethod('getTimeZoneName');
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}
