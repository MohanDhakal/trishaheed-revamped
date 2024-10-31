import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:trishaheed/features/routine/pages/facebook_login.dart';

// final navigatorKey = GlobalKey<NavigatorState>();
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
void mainMobile() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(FacebookLoginExample());
}
