import 'package:flutter/material.dart';

class NotifyAlert extends StatefulWidget {
  const NotifyAlert({super.key});

  @override
  State<NotifyAlert> createState() => _NotifyAlertState();
}

class _NotifyAlertState extends State<NotifyAlert> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notification Screen'),
    );
  }
}
