import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:trishaheed/features/routine/pages/new_page.dart';
import 'package:trishaheed/features/routine/routes.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
          static const platform = MethodChannel('com.example.trishaheed_revamped');

  static Future<void> init(GlobalKey<NavigatorState> key) async {
    // final String currentTimeZone = DateTime.now().timeZoneName;
    tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    final FlutterLocalNotificationsPlugin _notificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        key.currentState
            ?.push(MaterialPageRoute(builder: (_) => NotificationsPage()));
        print("received");
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  @pragma('vm:entry-point')
  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    print("background notification here");
    // handle action
  }

  Future<void> scheduleDailyNotification(DateTime selectedTime) async {
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(days: 1));
    }
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.local);
    try {
      final FlutterLocalNotificationsPlugin _notificationsPlugin =
          FlutterLocalNotificationsPlugin();

      await _notificationsPlugin.zonedSchedule(
        0,
        "notification title",
        "notification body",
        scheduledTime,
        _notificationDetails(),
        payload: Routes.notifications,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      debugPrint('Notification scheduled successfully');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'Scheduleed Notifications',
        'schedule_notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        actions: [
          AndroidNotificationAction(
            'action_open',
            'Action Open',
            showsUserInterface: true,
          ),
        ],
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotificationWithoutSound() async {
    PermissionStatus permissionGranted =
        await Permission.notification.request();
    if (permissionGranted == PermissionStatus.granted) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'no_sound_notification',
        'No Sound Notification',
        importance: Importance.max,
        priority: Priority.high,
        playSound: false, // Disable sound
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        1,
        'Notification without Sound',
        'This is a notification without sound.',
        platformChannelSpecifics,
      );
    }
  }

  Future<void> showNotificationWithSound() async {
    PermissionStatus permissionGranted =
        await Permission.notification.request();
    if (permissionGranted == PermissionStatus.granted) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'sound_notification',
        'Sound Notification',
        importance: Importance.max,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Notification with Sound',
        'This is a notification with sound.',
        platformChannelSpecifics,
      );
    }
  }

  void openExactAlarmSettings() {
    final intent = AndroidIntent(
      action:
          'android.settings.REQUEST_SCHEDULE_EXACT_ALARM', // This action opens the exact alarm settings page.
    );
    intent.launch();
  }
  /* Shows notification without using external package for notification  */
  Future<void> _showNotification() async {
    await Permission.notification.onDeniedCallback(() {
      print("permission temporarily denied");
    }).onGrantedCallback(() async {
      try {
        final notificationData =
            await platform.invokeMethod('showNotification', {
          'title': 'Test Notification',
          'message': 'This is a local notification from Flutter',
          'soundEnabled': true,
        });
        print(notificationData.toString());
      } on PlatformException catch (e) {
        print("Failed to show notification: '${e.message}'.");
      }
    }).onPermanentlyDeniedCallback(() {
      print("permission is permanently denied");
      openAppSettings();
    }).onRestrictedCallback(() {
      print("permission is restricted");
    }).onLimitedCallback(() {
      print("permission is limited");
    }).onProvisionalCallback(() {
      print("provisional callback");
    }).request();
  }
}

