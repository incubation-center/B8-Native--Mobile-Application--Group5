import 'package:go_router/go_router.dart';
import 'package:tukdak/screens/authscreen/forgotpassword.dart';
import 'package:tukdak/screens/authscreen/loginscreen.dart';

import '/screens/addCategory.dart';
import '/screens/addProperty.dart';
import '/screens/categoryScreen.dart';
import '/screens/mainScreen.dart';
import '../screens/authscreen/signupScreen.dart';

// GoRouter configuration
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const Signup(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgetpassword',
      builder: (context, state) => const ForgotpasswordSreen(),
    ),
    GoRoute(
      path: '/property',
      builder: (context, state) => const Category(),
    ),
    GoRoute(
      path: '/addproperty',
      builder: (context, state) => const AddProperty(),
    ),
    GoRoute(
      path: '/addcategory',
      builder: (context, state) => const addCategory(),
    ),
  ],
);
