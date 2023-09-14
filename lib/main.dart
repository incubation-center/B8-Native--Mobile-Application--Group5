import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';

import 'package:tukdak/screens/addCategory.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/authscreen/signupScreen.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/profilescreen.dart';
import 'package:tukdak/screens/Search.dart';
import '/config/routes.dart';

void main() {
  Get.put(NavBarController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoginScreen(),
      // home: HomePage(),
      // home: MainScreen(),
      // home: SearchScreen()
      // home: LoginScreen(),
      // home: Signup(),
      // home: ProfileScreen(),
    );
    // return GetMaterialApp(
    //   home: addCategory(),
    // );
  }
}
