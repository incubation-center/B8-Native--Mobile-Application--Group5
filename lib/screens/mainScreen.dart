import 'package:flutter/material.dart';
import 'package:tukdak/components/nav_bar.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // final NavBarController navBarController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Column(
            children: [
              Expanded(
                child: Center(
                  child: Text('Home'),
                ),
              ),
            ],
          ),
          Positioned(
            child: NavBar(), // Placing the bottom navigation bar at the bottom
          ),
        ],
      ),
      // bottomNavigationBar: navBar(),
      // body: const SafeArea(
      //   child: Center(
      //     child: Text('Home'),
      //   ),
      // ),
    );
  }
}
