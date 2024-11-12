import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:trishaheed/features/home_page.dart';

void main() {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return HomePage();
      },
    ),
  );
}
