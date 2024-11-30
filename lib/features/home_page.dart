import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trishaheed/features/auth/views/screen/login_screen.dart';
import 'package:trishaheed/features/auth/views/screen/school_registration_screen.dart';
import 'package:trishaheed/features/auth/views/screen/splash_screen.dart';
import 'package:trishaheed/features/dashboard_page.dart';
import 'package:trishaheed/features/dependency_injector.dart';
import 'package:trishaheed/utilities/data/CustomThemeData.dart';
import 'routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: DependencyInjector.providers(),
      child: MaterialApp(
        theme: CustomThemeData.studentResultAnalyzerTheme,
        routes: {
          Routes.home: (context) => DashboardPage(),
          Routes.schoolRegistration: (context) => SchoolRegistrationScreen(),
          Routes.schoolLogin: (context) => LoginScreen(),
          Routes.splashScreen: (context) => HomePage(),
        },
        home: SplashScreen(),
      ),
    );
  }
}
