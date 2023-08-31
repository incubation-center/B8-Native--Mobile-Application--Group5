import 'package:flutter/material.dart';

class NotificationModel {
  final IconData icon;
  final String title;
  final String body;
  final String time; // Add the time property

  NotificationModel({
    required this.icon,
    required this.title,
    required this.body,
    required this.time, // Pass the time property through the constructor
  });
}
