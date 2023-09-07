import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String body;
  final IconData icon;
  final DateTime time;
  // bool isRead; // Add this property

  NotificationModel({
    required this.title,
    required this.body,
    required this.icon,
    required this.time,
    // this.isRead = false, // Default value is false, indicating not read
  });
}