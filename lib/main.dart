import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/productbyid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
//       // home: LoginScreen(),
//       home: Eachproductscreen(),
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
