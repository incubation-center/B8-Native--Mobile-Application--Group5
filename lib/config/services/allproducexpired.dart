import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tukdak/config/services/category.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();
// getAllexpiredProducts
// http://127.0.0.1:8000/property/all/expired

Future<List<Map<String, dynamic>>> getAllexpiredProducts() async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://127.0.0.1:8000/property/all/expired');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Parse the response JSON
    final List<dynamic> data =
        json.decode(response.body); // Parse the JSON response
    final List<Map<String, dynamic>> productList = data
        .map((item) => item as Map<String, dynamic>)
        .toList(); // Convert data into List<Map<String, dynamic>>
    return productList;
  } else {
    // Handle errors or non-200 responses here.
    throw Exception("Failed to load products");
  }
}
