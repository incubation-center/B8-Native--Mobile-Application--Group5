import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';

import 'package:tukdak/screens/addCategory.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/authscreen/signupScreen.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/productAchive.dart';
import 'package:tukdak/screens/profilescreen.dart';
import 'package:tukdak/screens/Search.dart';
import '/config/routes.dart';

void main() async {
  // ignore: prefer_const_declarations
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String? token = await secureStorage.read(key: 'auth_token');
  Get.put(NavBarController());
  Get.put(const MainScreen());
  runApp(
    GetMaterialApp(
      initialRoute: token != null ? '/' : '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/', page: () => const MainScreen()),
        // Define other routes here as needed.
      ],
    ),
  );
}

// class MyApp extends StatelessWidget {
//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
//   @override
//   Widget build(BuildContext context) {
//     return const GetMaterialApp(
//       home: LoginScreen(),
//       // home: ProductAchivescreen(),
//       // home: HomePage(),
//       // home: MainScreen(),
//       // home: SearchScreen()
//       // home: LoginScreen(),
//       // home: Signup(),
//       // home: ProfileScreen(),
//     );
//     // return GetMaterialApp(
//     //   home: addCategory(),
//     // );
//   }
// }
