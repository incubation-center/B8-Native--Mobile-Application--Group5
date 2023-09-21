import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

// Future<String?> getUserprofile() async {
//   final token = await secureStorage.read(key: 'auth_token');
//   final url = Uri.parse('http://127.0.0.1:8000/user');

//   final response = await http.get(
//     url,
//     headers: {
//       'Authorization': 'Bearer $token',
//     },
//   );

//   if (response.statusCode == 200) {
//     // Return the response body as a String.

//     return response.body;
//   } else {
//     // Handle errors or non-200 responses here.
//     return null; // Return null or some other appropriate value.
//   }
// }
Future<Map<String, dynamic>?> getUserprofile() async {
  final token = await secureStorage.read(key: 'auth_token');
  // final url = Uri.parse('http://127.0.0.1:8000/user');
  final url = Uri.parse('http://18.143.209.45/user');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Parse the response JSON and return it as a Map
    final Map<String, dynamic> userData = json.decode(response.body);
    return userData;
  } else {
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}
