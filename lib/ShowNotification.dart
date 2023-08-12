import 'package:flutter/material.dart';

class ShowNotificationScreen extends StatefulWidget {
  const ShowNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ShowNotificationScreen> createState() => _ShowNotificationScreenState();
}

class _ShowNotificationScreenState extends State<ShowNotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiateNotification();
  }

  void initiateNotification() async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
