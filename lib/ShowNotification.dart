
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class ShowNotificationScreen extends StatefulWidget {
  const ShowNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ShowNotificationScreen> createState() => _ShowNotificationScreenState();
}

class _ShowNotificationScreenState extends State<ShowNotificationScreen> {
  final _localNotifications = FlutterLocalNotificationsPlugin();
    String message = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<void> showNotification(String message) async {

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
      message,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ElevatedButton(
          onPressed: () async{
            //showNotification( await fetchMessage());
          },
          child: Text(
            'Show Notification'
          )
      ),
    );
  }

  Future<String> fetchMessage() async {
    final response = await http.get(Uri.parse('https://c647-182-180-50-4.ngrok-free.app/notifications'));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        message = responseData['message'];
      });
      showNotification(message);
      return message;
    } else {
      setState(() {
        message = 'API call failed with status code: ${response.statusCode}';
      });
      showNotification(message);
    }
    return message;

  }
  

}
