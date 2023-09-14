import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;

  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
}