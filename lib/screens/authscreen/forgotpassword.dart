import 'package:flutter/material.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';
import 'package:tukdak/screens/authscreen/pincode.dart';

class ForgotpasswordSreen extends StatefulWidget {
  const ForgotpasswordSreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ForgotpasswordSreenState createState() => _ForgotpasswordSreenState();
}

class _ForgotpasswordSreenState extends State<ForgotpasswordSreen> {
  bool _rememberMe = false;
  bool _passwordVisible = false;
  void _navigateToSignupScreen(BuildContext context) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const LoginScreen()),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PinCodeScreen()),
    );
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
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "your email",
                    contentPadding: EdgeInsets.symmetric(vertical: 20),
                  ),
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
                _navigateToSignupScreen(context);
              },
              icon: const Icon(
                Icons.add_home_sharp,
                color: Colors.white,
              ),
              label: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
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
              GestureDetector(
                onTap: () {
                  _navigateToSignupScreen(context); // Navigate to signup screen
                },
                child: const Text(
                  " Back to login",
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

void main() {
  runApp(const MaterialApp(
    home: ForgotpasswordSreen(),
  ));
}
