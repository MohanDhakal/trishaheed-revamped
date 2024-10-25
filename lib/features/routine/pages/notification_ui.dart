import 'package:flutter/material.dart';
import 'package:trishaheed/features/routine/services/battery_service.dart';
import '../services/notification_service.dart';

class NotificationUi extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const NotificationUi({super.key, required this.navigatorKey});

  @override
  State<NotificationUi> createState() => _NotificationUiState();
}

class _NotificationUiState extends State<NotificationUi> {
  String _batteryLevel = "Unknown";
  final notificationService = NotificationService();
  final batteryService = BatteryService();

  @override
  void initState() {
    super.initState();
    NotificationService.init(widget.navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Routine Displaying...",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                onPressed: notificationService.showNotificationWithSound,
                child: Text(
                  "Sound Notification",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                onPressed: notificationService.showNotificationWithoutSound,
                child: Text(
                  "No Sound Notification",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  DateTime selectedTime =
                      DateTime.now().add(const Duration(minutes: 1));
                  notificationService.scheduleDailyNotification(selectedTime);
                },
                child: Text(
                  "Schedule Notification",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  _batteryLevel = await batteryService.getBatteryLevel();
                  setState(() {});
                },
                child: Text(
                  "Get Battery Level",
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Battery Level:",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 8),
              Text(
                "$_batteryLevel",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
