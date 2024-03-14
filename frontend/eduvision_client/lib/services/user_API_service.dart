import 'dart:convert';
import 'package:eduvision_client/model/user_profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAPIService {
  final String baseUrl = 'http://localhost:8080';

  UserAPIService();

  Future<void> signIn({required String id, required String password, required String role}) async {
    // Define the request body
    Map<String, dynamic> requestBody = {
      'id': id,
      'password': password,
      'role': role,
    };

    // Encode the request body
    String encodedBody = jsonEncode(requestBody);

    // Define the endpoint URL
    String url = '$baseUrl/signin';

    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Extract the token from the response
      String token = responseBody['token'];

      // Save the token in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      // Use the token as needed
      print('Token: $token');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }


  Future<void> register({
    required String fullname,
    required String email,
    required String password,
    required bool isStudent,
    required String idClass,
    required String role,
  }) async {
    // Define the request body
    Map<String, dynamic> requestBody = {
      'fullname': fullname,
      'email': email,
      'password': password,
      'isStudent': isStudent.toString(),
      'idClass': idClass,
      'role': role,
    };

    // Encode the request body
    String encodedBody = jsonEncode(requestBody);

    // Define the endpoint URL
    String url = '$baseUrl/user/register';

    // Make the POST request
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Print or handle the response as needed
      print('Register Response: $responseBody');
    } else {
      // Request failed
      print('Register Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> editPassword({
    required String id,
    required String password,
    required bool isStudent,
  }) async {
    // Define the request body
    Map<String, dynamic> requestBody = {
      'password': password,
      'isStudent': isStudent.toString(),
    };

    // Define the endpoint URL
    String url = '$baseUrl/editpassword/$id';

    // Encode the request body
    String encodedBody = jsonEncode(requestBody);

    // Make the PUT request
    http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: encodedBody,
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Print or handle the response as needed
      print('Edit Password Response: $responseBody');
    } else {
      // Request failed
      print('Edit Password Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

 Future<UserProfile?> fetchUserProfile(String token) async {
   print("aqui" + token);
  try {
    if (token == null) {
      print('Token is null');
      return null;
    }
    final response = await http.get(
      // Uri.parse('http://your_api_url.com/user/profile?secret_token=$token'),
      Uri.parse('$baseUrl/user/profile?secret_token=$token'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Add any additional headers if required
      },
    );

    if (response.statusCode == 200) {
      // Request successful, parse the response
      Map<String, dynamic> data = jsonDecode(response.body);
      return UserProfile(
        id: data['user']['id'],
        email: data['user']['email'],
        role: data['user']['role'],
        name: data['user']['name'],
      );
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (error) {
    // An error occurred
    print('Errora: $error');
    return null;
  }
}

}



void main() async {
  // Create an instance of APIService
  UserAPIService apiService = UserAPIService();

  // Replace 'your_id' and 'user_role' with actual values
  await apiService.signIn(id: 'your_id', role: 'user_role', password: 'a');
}
