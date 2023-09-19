// class Config {
//   static const String appName = "Tukdak App";
//   static const String apiURL = 'http://127.0.0.1:8000'; //PROD_URL
//   static const loginAPI = "/login";
//   static const registerAPI = "/user";
//   // static const userProfileAPI = "/users/user-Profile";
// }
import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tukdak/config/services/category.dart';


Future<String?> postObjectionPrediction(Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://18.140.59.77:8000/object-detection');
  // final url = Uri.parse(
  //     'http://127.0.0.1:8000/property/object-detection'); // Change the endpoint URL as needed.

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Adjust content type as needed.
    },
    body: json.encode(data), // Convert your data to JSON format.
  );
  print("------staus code: ${response.statusCode}");
  if (response.statusCode != 500) {
    final result = jsonDecode(response.body);
    final detectedObjects = result["objects"];
    final objectNames = detectedObjects.map((obj) => obj['name']).toList();
    print("Detected objet name: -------------- $objectNames");
    return objectNames.join(", ");
    // If the server returns a 200 OK response, parse the JSON.
  } else {
    print("Error Detection. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to send data to the backend detection');
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}
