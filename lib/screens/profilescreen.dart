// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tukdak/config/services/allproducexpired.dart';
import 'package:tukdak/config/services/userprofile.dart';
import 'package:tukdak/screens/addCategory.dart';

import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/homePage.dart';
import 'package:tukdak/screens/mainScreen.dart';
import 'package:tukdak/screens/productAchive.dart';
import 'package:get/get.dart';
import 'package:tukdak/config/services/userprofile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  void _navigateToMainScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainScreen()),
    // );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    // Navigator.of(context).pushReplacementNamed('/');
  }

  void _navigateToaddCategory(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainScreen()),
    // // );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const addCategory()));
  }

  void logout() async {
    // Clear the authentication token
    await secureStorage.delete(key: 'auth_token');
    // Get.to(const LoginScreen());
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
    // Navigate back to the login screen
    // ignore: use_build_context_synchronously
    // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _navigateToAchiveproductScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProductAchivescreen()),
    // );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ProductAchivescreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10.0),
        child: Container(
          // color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                // controller.homepage(0);
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Myprofile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.background,
                              width: 3),
                          image: const DecorationImage(
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: getUserprofile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Text("User information not available");
                        } else {
                          final userData = snapshot.data!;
                          final name =
                              userData["username"] ?? "Name not available";
                          final email =
                              userData["email"] ?? "Email not available";
                          return Column(
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.grey),
                              ),
                            ],
                          );
                        }
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomList(
                    imagesPath: "assets/images/order_svg.png",
                    text: "All Product Expired",
                    function: () {
                      _navigateToAchiveproductScreen(context);
                    }),
                CustomList(
                    imagesPath: "assets/images/wishlist_svg.png",
                    text: "All products",
                    function: () {
                      _navigateToaddCategory(context);
                    }),
                const SizedBox(
                  height: 6,
                ),
                const Divider(
                  thickness: 1,
                ),
                const SizedBox(
                  height: 6,
                ),
                const Text(
                  "Setting",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.login,
                color: Colors.white,
              ),
              label: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList({
    super.key,
    required this.imagesPath,
    required this.text,
    required this.function,
  });
  final String imagesPath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      title: Text(text),
      leading: Image.asset(
        imagesPath,
        height: 34,
      ),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
