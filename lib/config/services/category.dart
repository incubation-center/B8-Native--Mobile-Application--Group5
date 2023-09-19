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

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

//get
Future<List<Map<String, dynamic>>?> fetchDataWithToken() async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://18.140.59.77:8000/category/all');
  // final url = Uri.parse('http://127.0.0.1:8000/category/all');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Return the response body as a String.
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.cast<Map<String, dynamic>>();
    // return response.body;
  } else {
    throw Exception('Failed to load data from the backend');
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}

//post
Future<Map<String, dynamic>?> postCategoryDataWithToken(
    Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://18.140.59.77:8000/category');
  // final url = Uri.parse(
  //     'http://127.0.0.1:8000/category'); // Change the endpoint URL as needed.

  final response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Adjust content type as needed.
    },
    body: json.encode(data), // Convert your data to JSON format.
  );
  print("------staus code: ${response.statusCode}");
  if (response.statusCode == 202) {
    // If the server returns a 200 OK response, parse the JSON.
    return json.decode(response.body);
  } else {
    print("Error sending data to server. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to send data to the backend1');
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}

//delete
Future<Map<String, dynamic>?> deleteCategoryDataWithToken(String id) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://18.140.59.77:8000/category/$id');
  // final url = Uri.parse(
  //     'http://127.0.0.1:8000/category/$id'); // Use the provided ID in the URL.

  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Adjust content type as needed.
    },
  );
  print("------status code: ${response.statusCode}");
  if (response.statusCode == 200) {
    // If the server returns a 204 No Content response, it indicates a successful deletion.
    return null; // No response body for a successful deletion.
  } else {
    print(
        "Error sending delete request to server. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to delete data from the backend');
  }
}

//update
Future<Map<String, dynamic>?> putCategoryDataWithToken(
    String id, Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://18.140.59.77:8000/category/$id');
  // final url = Uri.parse(
  //     'http://127.0.0.1:8000/category/$id'); // Use the appropriate URL with the item ID.

  final response = await http.put(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Adjust content type as needed.
    },
    body: json.encode(data), // Convert your data to JSON format.
  );

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    return json.decode(response.body);
  } else {
    print("Error sending data to server. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to update data on the backend');
  }
}
