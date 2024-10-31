import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trishaheed/model/gallery_state.dart';
import 'package:trishaheed/model/states/EventState.dart';
import 'package:trishaheed/model/states/dowloads_state.dart';
import 'package:trishaheed/model/states/smc_state.dart';
import 'package:trishaheed/model/states/staff_state.dart';
import 'package:trishaheed/model/states/students_state.dart';
import 'package:url_strategy/url_strategy.dart';
import 'pages/entry_point.dart';
import 'services/HiveStorage.dart';
import 'states/menu_state.dart';
import 'package:timezone/data/latest.dart' as tz;

void mainWeb() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Flutter to initialize
  await initHive();
  setPathUrlStrategy();
  tz.initializeTimeZones();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuState()),
        ChangeNotifierProvider(create: (_) => StudentState()),
        ChangeNotifierProvider(create: (_) => GalleryState()),
        ChangeNotifierProvider(create: (_) => StaffState()),
        ChangeNotifierProvider(create: (_) => DownloadState()),
        ChangeNotifierProvider(create: (_) => SmcState()),
        ChangeNotifierProvider(create: (_) => EventState()),
      ],
      child: EntryPoint(),
    ),
  );
}