import 'package:flutter/foundation.dart';
import 'package:trishaheed/main_mobile.dart';
import 'package:trishaheed/main_web.dart';

void main() {
  kIsWeb ? mainWeb() : mainMobile();
  // mainWeb();
}
