import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>?> fetchPropertyDataWithToken() async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://127.0.0.1:8000/property/all');

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
Future<Map<String, dynamic>?> postPropertyDataWithToken(Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://127.0.0.1:8000/property'); // Change the endpoint URL as needed.

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
Future<Map<String, dynamic>?> deletePropertyDataWithToken(String id) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://127.0.0.1:8000/property/$id'); // Use the provided ID in the URL.

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
