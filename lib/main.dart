import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/productbyid.dart';
import 'package:tukdak/screens/authscreen/firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String? token = await secureStorage.read(key: 'auth_token');
  await Firebase.initializeApp(
  );
  await FirebaseAPI().initNotifications();
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


