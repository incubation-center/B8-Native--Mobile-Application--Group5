import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tukdak/screens/propertyList.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:get/get.dart';
import 'package:tukdak/controller/NavController.dart';
import 'package:tukdak/screens/notifyAlert.dart'; // Import the NotifyAlert class
import 'package:tukdak/screens/Search.dart';
import 'package:tukdak/screens/categoryScreen.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/models/notification_model.dart'; // Import the NotificationModel class


class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);

  final NavBarController controller = Get.put(NavBarController());
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<List<CameraDescription>> initializeCameras() async {
    return await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ClipRRect(
          // borderRadius: const BorderRadius.only(topRight: Radius.circular(25)),
          child: PageView(
            onPageChanged: controller.animateToTab,
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              Category(),
            FutureBuilder<List<CameraDescription>>(
              future: initializeCameras(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final cameras = snapshot.data;
                  if (cameras != null) {
                    return AddProperty(cameras: cameras); // Pass the cameras list to AddProperty
                  } else {
                    return Center(
                      child: Text('Error: Unable to initialize cameras.'),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
              SearchScreen(),
              // PropertyList(),
              NotifyAlert(notifications: [
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Reminder",
                  body:
                      "Hey, heads-up! Your Coca-Cola is nearing expiration. Savour it soon!",
                  time: DateTime.parse(
                      "2023-09-01 09:00:00"), // Replace with the actual time
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Friendly reminder",
                  body:
                      "Your chicken's expiry date is coming up. Time for a tasty meal!",
                  time: DateTime.parse(
                      "2023-09-01 09:00:00"), // Replace with the actual time
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Reminder",
                  body:
                      "Hey! Your veggies are almost expired. Perfect time for a healthy meal.",
                  time: DateTime.parse(
                      "2023-09-01 09:00:00"), // Replace with the actual time
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Reminder",
                  body:
                      "Your chicken's expiry date is coming up. Time for a tasty meal!",
                  time: DateTime.parse("2023-09-01 09:00:00"),
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Password reset",
                  body: "Your password has been restored successfully.",
                  time: DateTime.parse("2023-09-01 09:00:00"),
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Hello",
                  body:
                      "Hey! You have successfully logged into the property management. Please enjoy your experience with our app.",
                  time: DateTime.parse("2023-09-01 09:00:00"),
                ),
                NotificationModel(
                  icon: Icons.notification_important,
                  title: "Hello",
                  body:
                      "You have successfully created an account with Property Management.",
                  time: DateTime.parse("2023-09-01 09:00:00"),
                ),
              ]),
            ],
          ),
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
                    label: "Home",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Icons.category_rounded,
                    page: 1,
                    label: "Category",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Icons.camera_alt_rounded,
                    page: 2,
                    label: "Add",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Icons.search,
                    page: 3,
                    label: "Search",
                  ),
                  _bottomAppBarItem(
                    context,
                    icon: Icons.notifications,
                    page: 4,
                    label: "Notify",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required IconData icon, required int page, required String label}) {
    return ZoomTapAnimation(
      // onTap: () => controller.goToTab(page),
      onTap: () async {
        // Check if the user is authenticated
        final token = await secureStorage.read(key: 'auth_token');
        if (token != null ||
            page != 2 /* Replace with the index of your login page */) {
          controller.goToTab(page);
        } else {
          // If not authenticated, you can navigate to the login screen or show a message
          Get.toNamed('/login'); // Example navigation to the login screen
        }
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: controller.currentPage.value == page
                  ? Color(0xFF44576D)
                  : Colors.white,
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.currentPage == page
                    ? Color(0xFF44576D)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      home: NavBar(),
    );
  }
}
