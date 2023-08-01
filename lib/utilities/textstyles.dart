import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle? menu(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: Colors.white70,
        );
  }

  static TextStyle? formHeading(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        );
  }

  static TextStyle? quote(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        );
  }
}
