import 'package:flutter/material.dart';
import 'package:tukdak/screens/Search.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/screens/categoryScreen.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/notifyAlert.dart';

class navBar extends StatelessWidget {
  navBar({super.key});

  final NavBarController controller = Get.put(NavBarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          onPageChanged: controller.animateToTab,
          controller: controller.pageController,
          physics: const BouncingScrollPhysics(),
          children: const [
            HomePage(),
            Category(),
            AddProperty(),
            Search(),
            NotifyAlert(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 80,
        elevation: 0,
        notchMargin: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            color: Color(0xFFAAC7D7),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomAppBarItem(
                      context,
                      icon: Icons.home_rounded,
                      page: 0,
                      label: "Home"),
                  _bottomAppBarItem(
                      context,
                      icon: Icons.category_rounded,
                      page: 1,
                      label: "Category"),
                  _bottomAppBarItem(
                      context,
                      icon: Icons.camera_alt_rounded,
                      page: 2,
                      label: "Add"),
                  _bottomAppBarItem(
                      context,
                      icon: Icons.search,
                      page: 3,
                      label: "Search"),
                  _bottomAppBarItem(
                      context,
                      icon: Icons.notifications,
                      page: 4,
                      label: "Notify"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => controller.goToTab(page),
      child: Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon,
                color: controller.currentPage.value == page ? Color(0xFF44576D) :
                Colors.white),
                Text(label, style: TextStyle(color:controller.currentPage == page ? Color(0xFF44576D) :
                Colors.white))
              ],
            ),
        ),
      );
  }
}
