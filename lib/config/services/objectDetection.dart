// class Config {
//   static const String appName = "Tukdak App";
//   static const String apiURL = 'http://18.140.59.77'; //PROD_URL
//   static const loginAPI = "/login";
//   static const registerAPI = "/user";
//   // static const userProfileAPI = "/users/user-Profile";
// }
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tukdak/config/services/category.dart';


Future<String?> postDetectionImage(Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://18.140.59.77/property/object-detection');

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

  print("request");
  print(request.files);

  try {
    final responseStreamed = await request.send();
    // Convert the StreamedResponse to a Response
    final response = await http.Response.fromStream(responseStreamed);
    print("status code---: ${response.statusCode}");
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['object']);
      return data['object'];
      // return json.decode(response.body);
    } else {
      print('Error: ${response.reasonPhrase}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}