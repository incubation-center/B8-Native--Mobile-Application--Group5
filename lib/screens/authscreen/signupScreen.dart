import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _password1Visible = false;
  bool _password2Visible = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  // void _navigateToSignupScreen(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const LoginScreen()),
  //   );
  // }

  void _showSuccessAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signup Successful'),
          content: const Text('Please verify your Email !!!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
                _navigateToLoginScreen(context); // Navigate to the login screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void signup(String name, String email, password1, password2) async {
    try {
      // Log the input values
      print("Name: $name");
      print("Email: $email");
      print("Password1: $password1");
      print("Password2: $password2");
      final response = await http.post(
        // Uri.parse('http://127.0.0.1:8000/user'),
        Uri.http("localhost:8000", '/user'),
        headers: <String, String>{
          "Access-Control-Allow-Origin": "*",
          'Content-Type': 'application/json',
          'Accept': '*/*'
        },
        body: jsonEncode(<String, String>{
          "username": name,
          "email": email,
          "password1": password1,
          "password2": password2
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        // _navigateToLoginScreen(context);
        _showSuccessAlert(context);
      } else {
        print("Sign up has some mistake!!!");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                  "Sign Up",
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
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    labelText: "your name",
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    labelText: "your email",
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password1Controller,
                  obscureText: !_password1Visible,
                  decoration: InputDecoration(
                    hintText: "Enter password ",
                    labelText: "Password",
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      icon: Icon(
                        _password1Visible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _password1Visible = !_password1Visible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password2Controller,
                  obscureText: !_password2Visible,
                  decoration: InputDecoration(
                    hintText: "Confirm Password ",
                    labelText: "Type your password again",
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    suffixIcon: IconButton(
                      iconSize: 20,
                      icon: Icon(
                        _password2Visible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _password2Visible = !_password2Visible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
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
                // Retrieve values from the text controllers
                String name = usernameController.text;
                String email = emailController.text;
                String password1 = password1Controller.text;
                String password2 = password2Controller.text;

                // Call the signup function with the retrieved values
                signup(name, email, password1, password2);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                "Register",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Center(
            child: Text("or sign up with social media"),
          ),
          const SizedBox(
            height: 5,
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
              const Text("Already have an account ?"),
              GestureDetector(
                onTap: () {
                  // _navigateToSignupScreen(context); // Navigate to signup screen
                },
                child: const Text(
                  " Sign in",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    decorationThickness: 2.0,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueGrey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
