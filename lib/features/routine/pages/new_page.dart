import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Sample list of notifications
  List<NotificationModel> notifications = [
    NotificationModel(title: 'New Message', body: 'You have a new message.'),
    NotificationModel(
        title: 'System Update', body: 'Update available for your system.'),
    NotificationModel(
        title: 'Event Reminder',
        body: 'Don\'t forget about your event tomorrow.'),
  ];

  // Clear all notifications
  void _clearAllNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          // Clear All Button
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: notifications.isNotEmpty ? _clearAllNotifications : null,
          ),
        ],
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notifications[index].title),
                  subtitle: Text(notifications[index].body),
                );
              },
            )
          : Center(
              child: Text('No notifications'),
            ),
    );
  }
}
