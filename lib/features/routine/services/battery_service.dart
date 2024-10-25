
import 'package:flutter/services.dart';

class BatteryService {
    static const platform = MethodChannel('com.example.trishaheed_revamped');

  Future<String> getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery Level $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}";
    }
    return batteryLevel;
 
  }
}