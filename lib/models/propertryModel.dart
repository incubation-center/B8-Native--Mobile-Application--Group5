// import 'dart:ffi';

// import 'package:flutter/material.dart';

class PropertyModel {
  String propertyName;
  String category;
  String value;
  bool expire;
  DateTime pickedDate;
  int alert;

  PropertyModel(
      {
        required this.propertyName,
        required this.category,
        required this.value,
        required this.expire,
        required this.pickedDate,
        required this.alert,});
}