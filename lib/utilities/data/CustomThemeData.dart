import 'package:flutter/material.dart';

class CustomThemeData {
  static final ThemeData studentResultAnalyzerTheme = ThemeData(
    primaryColor: Color(0xFFFFA500),
    // Light orange color
    scaffoldBackgroundColor: Color(0xFFF9F9F9),
    // Light background color
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFA500), // Light orange app bar
      foregroundColor: Colors.white, // White text color for app bar
      elevation: 4.0, // Shadow elevation for app bar
    ),
    colorScheme: ColorScheme(
      primary: Color(0xFFFFA500),
      // Primary color (light orange)
      primaryContainer: Color(0xFFFFD54F),
      // Optional: a lighter variant of the primary
      secondary: Color(0xFF6200EA),
      // Secondary color (purple shade)
      secondaryContainer: Color(0xFFBB86FC),
      // Optional: a lighter variant of secondary
      surface: Colors.white,
      // Surface color (for cards, etc.)
      error: Colors.red,
      // Error color
      onPrimary: Colors.white,
      // Text color on primary color
      onSecondary: Colors.white,
      // Text color on secondary color
      onSurface: Colors.black,
      // Text color on surface
      onError: Colors.white,
      // Text color on error
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
    cardColor: Color(0xFFFFFFFF),
    // White for cards
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
}
