import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ShowNotificationScreen extends StatefulWidget {
  const ShowNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ShowNotificationScreen> createState() => _ShowNotificationScreenState();
}

class _ShowNotificationScreenState extends State<ShowNotificationScreen> {
  final _localNotifications = FlutterLocalNotificationsPlugin();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateNotification();
  }

  Future<void> showNotification() async {

    WidgetsFlutterBinding.ensureInitialized();
    await _localNotifications.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'), // Replace with your app icon
      ),
    );

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id',
      'Your Channel Name',
      importance: Importance.max,
      ticker: 'ticker',
      playSound: true,
      priority: Priority.max,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotifications.show(
      0, // Notification ID
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ElevatedButton(
          onPressed: () => showNotification(),
          child: Text(
            'Show Notification'
          )
      ),
    );
  }
}
