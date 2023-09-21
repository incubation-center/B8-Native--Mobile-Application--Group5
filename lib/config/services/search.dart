import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tukdak/config/services/category.dart';

// ignore: non_constant_identifier_names
Future<List<Map<String, dynamic>>?> SearchData(String name) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://18.140.59.77/property/search/$name');
  
  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    // Return the response body as a List of Maps.
    final List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load data from the backend');
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}
