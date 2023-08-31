import 'package:flutter/material.dart';
import 'package:tukdak/components/nav_bar.dart';
import 'package:get/get.dart';
import 'package:tukdak/components/profilebar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFFAAC7D7),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Profilebar(),
      ),
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
