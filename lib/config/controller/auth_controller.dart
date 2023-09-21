// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class AuthController extends GetxController {
//   final String apiUrl = 'http://18.140.59.77';
//   final String loginEndpoint = '/login';

//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$apiUrl$loginEndpoint'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );

//       if (response.statusCode == 200) {
//         // Parse the JWT token from the response and store it securely.
//         final token = response.body;
//         // Save the token using your preferred method, e.g., secure storage.
//         // Example using GetStorage:
//         // GetStorage().write('token', token);

//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return false;
//     }
//   }
// }
