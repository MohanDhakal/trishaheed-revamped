import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trishaheed/features/routine/pages/routine_display.dart';
import 'package:timezone/data/latest.dart' as tz;

// final navigatorKey = GlobalKey<NavigatorState>();
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
void mainMobile() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(RoutineDisplay());
}
