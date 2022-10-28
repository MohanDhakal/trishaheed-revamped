import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle? menu(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white70,
        );
  }
}
