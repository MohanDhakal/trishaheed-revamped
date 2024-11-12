import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:trishaheed/features/auth/service/school_registration_service.dart';
import 'package:trishaheed/features/auth/viewmodel/auth/school_registration_cubit.dart';
import 'package:trishaheed/features/auth/viewmodel/onboarding/onboarding_cubit.dart';
import 'package:trishaheed/features/auth/views/screen/login_screen.dart';
import 'package:trishaheed/features/auth/views/screen/school_registration_screen.dart';
import 'package:trishaheed/features/auth/views/screen/splash_screen.dart';
import 'package:trishaheed/features/dashboard_page.dart';
import 'auth/repository/school_registration_repo.dart';
import 'routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ThemeData studentResultAnalyzerTheme = ThemeData(
    primaryColor: Color(0xFFFFA500), // Light orange color
    scaffoldBackgroundColor: Color(0xFFF9F9F9), // Light background color
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFA500), // Light orange app bar
      foregroundColor: Colors.white, // White text color for app bar
      elevation: 4.0, // Shadow elevation for app bar
    ),
    colorScheme: ColorScheme(
      primary: Color(0xFFFFA500), // Primary color (light orange)
      primaryContainer:
          Color(0xFFFFD54F), // Optional: a lighter variant of the primary
      secondary: Color(0xFF6200EA), // Secondary color (purple shade)
      secondaryContainer:
          Color(0xFFBB86FC), // Optional: a lighter variant of secondary
      surface: Colors.white, // Surface color (for cards, etc.)
      error: Colors.red, // Error color
      onPrimary: Colors.white, // Text color on primary color
      onSecondary: Colors.white, // Text color on secondary color
      onSurface: Colors.black, // Text color on surface
      onError: Colors.white, // Text color on error
      brightness: Brightness.light, // Theme brightness
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6200EA), // Purple for headlines
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black, // Default text color
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black54, // Secondary text color
      ),
    ),
    cardColor: Color(0xFFFFFFFF), // White for cards
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFA500), // Light orange for elevated buttons
        foregroundColor: Colors.black, // Text color on buttons
      ),
    ),
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
            BorderSide(color: Color(0xFF6200EA), width: 1), // Purple border
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
            color: Color(0xFFFFA500), width: 2), // Light orange focused border
      ),
    ),
  );
  final SchoolRegistrationRepo loadingRepo = SchoolRegistrationRepo.initial();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: studentResultAnalyzerTheme,
      routes: {
        Routes.home: (context) => DashboardPage(),
        Routes.schoolRegistration: (context) => SchoolRegistrationScreen(),
        Routes.schoolLogin: (context) => LoginScreen(),
      },
      home: MultiProvider(
        providers: [
          // Register your dependencies at the top level
          FutureProvider<SchoolRegistrationRepo>(
            create: (_) => SchoolRegistrationRepo.create(),
            initialData: SchoolRegistrationRepo.initial(),
          ),
          ProxyProvider<SchoolRegistrationRepo, SchoolRegistrationService>(
            update: (_, repo, __) => repo != loadingRepo
                ? SchoolRegistrationService(repo)
                : SchoolRegistrationServiceInitial(repo),
          ),
          BlocProvider<OnboardingCubit>(create: (context) {
            final service = context.read<SchoolRegistrationService?>();
            if (service == null ||
                service is SchoolRegistrationServiceInitial) {
              throw Exception("SchoolRegistrationService is not initialized");
            } else {
              return OnboardingCubit(service);
            }
          }),
          BlocProvider<SchoolRegistrationCubit>(create: (context) {
            final service = context.read<SchoolRegistrationService?>();
            if (service == null ||
                service is SchoolRegistrationServiceInitial) {
              throw Exception("SchoolRegistrationService is not initialized");
            } else {
              return SchoolRegistrationCubit(service);
            }
          }),
        ],
        child: SplashScreen(),
      ),
    );
  }
}
