import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>?> fetchPropertyDataWithToken() async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://18.143.209.45/property/all');
  // final url = Uri.parse('http://18.143.209.45/property/all');

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
  final url = Uri.parse('http://18.143.209.45/property');

  final request = http.MultipartRequest('POST', url);

  // Add the Bearer token to the request headers
  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'multipart/form-data';
  const String fieldName = 'image';
  final File imageFile = data['image'];
  // final File imageFile = File('assets/images/img.png');
  print(imageFile);

  if (await imageFile.exists()) {
    // The file exists, proceed with your request.
    print("exist");
  }

  // Add the file to the request
  final fileStream = http.ByteStream(imageFile.openRead());
  final length = imageFile.lengthSync();
  final multipartFile = http.MultipartFile(fieldName, fileStream, length,
      filename: imageFile.path.split('/').last,
  );

  print(fileStream);
  print(length);
  print(imageFile.path.split('/').last);

  request.files.add(multipartFile);
  print(multipartFile);

  // Add additional fields to the request (e.g., form data)
  request.fields['name'] = data['name'];
  request.fields['price'] = data['price'];
  request.fields['categoryId'] = data['categoryId'];
  request.fields['alert_at'] = data['alert_at'];
  request.fields['expired_at'] = data['expired_at'];

  print("request");
  print(request.files);

  final responseStreamed = await request.send();

  // Convert the StreamedResponse to a Response
  final response = await http.Response.fromStream(responseStreamed);

  if (response.statusCode == 202) {
    // If the server returns a 200 OK response, parse the JSON.
    return json.decode(response.body);
  } else {
    throw Exception('Failed to send data to the backend1');
  }
}

//delete
Future<Map<String, dynamic>?> deletePropertyDataWithToken(String id) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse(
      'http://18.143.209.45/property/$id');
  final response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Adjust content type as needed.
    },
  );
  print("------status code: ${response.statusCode}");
  if (response.statusCode == 200) {
    return null; // No response body for a successful deletion.
  } else {
    print(
        "Error sending delete request to server. Status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    throw Exception('Failed to delete data from the backend');
  }
}
