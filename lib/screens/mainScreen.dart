import 'package:flutter/material.dart';
import 'package:tukdak/components/nav_bar.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      body: const Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Text('Home'),
                ),
              ),
            ],
          ),
          // Positioned(
          //   // child: NavB, // Placing the bottom navigation bar at the bottom
          // ),
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
