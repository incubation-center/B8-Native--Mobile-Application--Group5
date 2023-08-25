import 'package:flutter/material.dart';
import 'package:tukdak/components/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: navBar(),
      body: SafeArea(
        child: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
