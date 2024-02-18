import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trishaheed/utilities/my_app_router_information_parser.dart';

import 'myapp_router_delegate.dart';

class EntryPoint extends StatelessWidget {
  final delegate = MyAppRouterDelegate();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "STSSS",
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      themeMode: ThemeMode.dark,
      // color: Colors.black,
      theme: ThemeData(
        // fontFamily: 'OpenSans',
        textTheme: TextTheme(
          displaySmall: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
          displayMedium: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
          displayLarge: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
        ),
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: MyAppRouterInformationParser(),
      routerDelegate: delegate,
    );
  }
}
