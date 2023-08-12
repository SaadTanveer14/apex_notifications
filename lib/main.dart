import 'dart:convert';

import 'package:apex_notifications/ShowNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;

final _localNotifications = FlutterLocalNotificationsPlugin();
String message = '';

void callbackDispatcher() async{
  Workmanager().executeTask((task, inputData) async {
    // Perform your API call here and handle the response
    // If the API response is successful, show a notification
    // using the flutter_local_notifications package
    await fetchMessage();
    return Future.value(true);
  });
}

Future<String> fetchMessage() async {
  final response = await http.get(Uri.parse('https://c647-182-180-50-4.ngrok-free.app/notifications'));

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    message = responseData['message'];

    // setState(() {
    // });
    showNotification(message);
    return message;
  } else {
    message = 'API call failed with status code: ${response.statusCode}';

    // setState(() {
    // });
    showNotification(message);
  }
  return message;

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



void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
  //Workmanager().registerOneOffTask("task-identifier", "simpleTask", );
  Workmanager().registerPeriodicTask(
    "periodic-task-identifier",
    "simplePeriodicTask",
    frequency: Duration(seconds: 30),
    inputData: <String, dynamic>{},
  );
  runApp(const MyApp());
}





class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShowNotificationScreen(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }