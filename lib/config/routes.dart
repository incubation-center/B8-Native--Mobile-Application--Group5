import 'package:go_router/go_router.dart';
import 'package:tukdak/screens/addProperty.dart';
import 'package:tukdak/screens/categoryScreen.dart';

import '/screens/mainScreen.dart';
import '/screens/signupScreen.dart';

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
      path: '/property',
      builder: (context, state) => const Category(),
    ),
    GoRoute(
      path: '/addproperty',
      builder: (context, state) => const AddProperty(),
    ),
  ],
);
