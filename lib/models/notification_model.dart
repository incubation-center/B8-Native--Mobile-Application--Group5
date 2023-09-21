import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String body;
  final String imageUrl; // Add this property
  final DateTime time;

  NotificationModel({
    required this.title,
    required this.body,
    required this.imageUrl, // Update the constructor
    required this.time,
  });
}
