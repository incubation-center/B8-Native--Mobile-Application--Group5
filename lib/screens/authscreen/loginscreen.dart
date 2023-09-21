import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tukdak/screens/authscreen/forgotpassword.dart';
import 'package:tukdak/screens/authscreen/signupScreen.dart';
import 'package:tukdak/screens/mainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _passwordVisible = false;
  bool visible = false;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
  }

  Future<void> checkTokenAndNavigate() async {
    final String? token = await secureStorage.read(key: 'auth_token');
    if (token != null) {
      // ignore: use_build_context_synchronously
      _navigateToMainScreen(context);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://18.140.59.77/login'),
        // Uri.parse('http://18.140.59.77/login'),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final String token = jsonResponse['accessToken'];

        await secureStorage.write(key: 'auth_token', value: token);

        if (token != null) {
          _navigateToMainScreen(context);
        } else {
          showSnackbar('Authentication failed. Please check your credentials.');
        }
      } else {
        showSnackbar('Authentication failed. Please check your credentials.');
      }
    } catch (e) {
      print('Error: $e');
      showSnackbar(
          'An error occurred while trying to log in. Please try again later.');
    }
  }

  void showSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: const Color.fromARGB(255, 170, 215, 206),
    );
  }

  // void login(String email, password) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Get.snackbar(
  //       'Error',
  //       'No internet connection. Please check your network settings',
  //       backgroundColor: const Color.fromARGB(255, 170, 215, 206),
  //     );
  //     return;
  //   }

  //   try {
  //     // Log the input values
  //     // ignore: avoid_print
  //     print("Email: $email");
  //     // ignore: avoid_print
  //     print("Password: $password");
  //     final response = await http.post(
  //       // Uri.parse('http://18.140.59.77/user'),
  //       Uri.http("localhost:8000", '/login'),
  //       headers: <String, String>{
  //         "Access-Control-Allow-Origin": "*",
  //         'Content-Type': 'application/json',
  //         'Accept': '*/*'
  //       },
  //       body:
  //           jsonEncode(<String, String>{"email": email, "password": password}),
  //     );
  //     // print(response.body);
  //     if (response.statusCode == 200) {
  //       // ignore: use_build_context_synchronously
  //       final jsonResponse = json.decode(response.body);
  //       final String token = jsonResponse['accessToken'];

  //       // Store the token securely (e.g., using secure_storage)
  //       await secureStorage.write(key: 'auth_token', value: token);

  //       if (token != null) {
  //         // Log the token
  //         print("Token: $token");
  //         // Store the token securely
  //         await secureStorage.write(key: 'auth_token', value: token);
  //         // ignore: use_build_context_synchronously
  //         _navigateToMainScreen(context);
  //       } else {
  //         // Handle the case where 'token' is null in the response
  //         Get.snackbar(
  //           'Error',
  //           'Authentication failed. Please check your credentials.',
  //           backgroundColor: const Color.fromARGB(255, 170, 215, 206),
  //         );
  //       }
  //       // ignore: use_build_context_synchronously
  //       // _navigateToHomeScreen(context);
  //     } else {
  //       // Authentication failed
  //       Get.snackbar(
  //         'Error',
  //         'Authentication failed. Please check your credentials.',
  //         backgroundColor: const Color.fromARGB(255, 170, 215, 206),
  //         // snackPosition: SnackPosition.BOTTOM,
  //       );
  //       print("Sign ip has some mistake!!!");
  //     }
  //   } catch (e) {
  //     // Error occurred during the API request
  //     print('Error: $e');
  //     Get.snackbar(
  //       'Error',
  //       'An error occurred while trying to log in. Please try again later.',
  //       backgroundColor: const Color.fromARGB(255, 170, 215, 206),
  //     );
  //   }
  // }

  // void onPressedLoginButton() {
  //   final email = emailController.text;
  //   final password = passwordController.text;

  //   if (email.isNotEmpty && password.isNotEmpty) {
  //     login(email, password);
  //   } else {
  //     if (email.isEmpty || password.isEmpty) {
  //       Get.snackbar(
  //         'Error',
  //         'Both email and password are required',
  //         backgroundColor: Color.fromARGB(255, 170, 215, 206),
  //       );
  //       return;
  //     }
  //   }
  // }
  void onPressedLoginButton() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      login(email, password);
    } else {
      showSnackbar('Both email and password are required');
    }
  }

  void _navigateToSignupScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const Signup()),
    // );
    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    Get.to(const Signup());
  }

  void _navigateToMainScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const MainScreen()),
    // );
    // Get.to(const MainScreen());
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
    // Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _navigateToForgotpasswordScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ForgotpasswordSreen()),
    // );
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const ForgotpasswordSreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("assets/images/img.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Welcome to, Name",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter Username Here",
                      labelText: "Username",
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: !_passwordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter password ",
                      labelText: "Password",
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      suffixIcon: IconButton(
                        iconSize: 20,
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            _rememberMe = newValue!;
                          });
                        },
                      ),
                      const Text("Remember Me"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(118, 138, 149, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    minimumSize: const Size(300, 50)),
                onPressed: () {
                  // login(emailController.text, passwordController.text);
                  onPressedLoginButton();
                  // _navigateToMainScreen(context);
                },
                icon: const Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                label: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _navigateToForgotpasswordScreen(
                        context); // Navigate to signup screen
                  },
                  child: const Text(
                    "Forgot password",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                "OR",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.facebook,
                  color: Colors.blue,
                  size: 34,
                ),
                Image.asset(
                  'assets/images/google.png',
                  width: 34,
                  height: 34,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn’t have an account ?"),
                GestureDetector(
                  onTap: () {
                    _navigateToSignupScreen(
                        context); // Navigate to signup screen
                  },
                  child: const Text(
                    " Sign up",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      decorationThickness: 2.0,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blueGrey,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginScreen(),
  ));
}
