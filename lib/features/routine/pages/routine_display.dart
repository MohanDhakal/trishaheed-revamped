import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trishaheed/features/routine/pages/dev_tool.dart';

class RoutineDisplay extends StatefulWidget {
  const RoutineDisplay({
    super.key,
  });

  @override
  State<RoutineDisplay> createState() => _RoutineDisplayState();
}

class _RoutineDisplayState extends State<RoutineDisplay> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Add other locales you want to support
      ],
      home: DevToolPractice(),
    );
  }
}
