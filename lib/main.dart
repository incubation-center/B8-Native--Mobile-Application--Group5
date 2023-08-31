import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/screens/addCategory.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:tukdak/screens/mainScreen.dart';
import '/config/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
          // home: LoginScreen(),
          home: MainScreen(),
          // home: Signup(),
    );
  }
}
