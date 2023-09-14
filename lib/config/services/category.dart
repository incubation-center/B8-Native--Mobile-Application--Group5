// class Config {
//   static const String appName = "Tukdak App";
//   static const String apiURL = 'http://127.0.0.1:8000'; //PROD_URL
//   static const loginAPI = "/login";
//   static const registerAPI = "/user";
//   // static const userProfileAPI = "/users/user-Profile";
// }
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<String?> fetchDataWithToken() async {
  final token = await secureStorage.read(key: 'auth_token');
  final url = Uri.parse('http://127.0.0.1:8000/category/all');

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Return the response body as a String.
    
    return response.body;
  } else {
    // Handle errors or non-200 responses here.
    return null; // Return null or some other appropriate value.
  }
}
