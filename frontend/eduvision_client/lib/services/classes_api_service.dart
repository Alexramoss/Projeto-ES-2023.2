import 'dart:convert';
import 'package:eduvision_client/model/classes_structure.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClassesAPIService {
  final String baseUrl = 'http://localhost:8080';


Future<String> createClass(String classname, String letter, String modality) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }

    String baseUrl = 'http://localhost:8080'; // Update with your base URL
    Uri url = Uri.parse('$baseUrl/user/classes');

    final http.Response response = await http.post(
      url.replace(queryParameters: {'secret_token': token}), // Include token as query parameter
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'classname': classname,
        'letter': letter,
        'modality': modality,
  
      }),
    );

    if (response.statusCode == 201) {
      // Request successful, handle response
      print(response.body);

      return ('Turma criada com sucesso!');
    } else {
      // Request failed, handle error
            print(response.body);

      return ('Erro: ${response.statusCode}');
    }
  } catch (error) {
    // Handle exceptions
    return ('Erro: $error');
  }
}

// Future<List<dynamic>> getAllClasses({String? classname, String? letter, String? modality, String? minId, String? maxId}) async {
//   try {
//     // Retrieve the token from shared preferences
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');

//     // Check if the token is null or empty
//     if (token == null || token.isEmpty) {
//       return(['Token is null or empty']);
      
//     }

//     // Construct the URL with query parameters
//     final Uri url = Uri.parse('$baseUrl/user/classes?classname=$classname&letter=$letter&modality=$modality&minId=$minId&maxId=$maxId&secret_token=$token');
    
//     // Make the HTTP GET request
//     final response = await http.get(url);

//     // Check if the request was successful (status code 200)
//     if (response.statusCode == 200) {
//       // Parse the JSON response
//       final List<dynamic> classes = json.decode(response.body);
      
//       // Handle the classes data
//       print('Classes: $classes');
//       return classes;

//     } else {
//       // Handle the error response
//             print(['Failed to fetch classes. Status code: ${response.statusCode}']);

//       return(['Failed to fetch classes. Status code: ${response.statusCode}']);
//     }
//   } catch (error) {
//     // Handle any errors that occur during the process
//     print('Error: $error');
//         throw ('Error: $error');

//   }
// }

Future<List<ClassesStructure>> getAllClasses({String? classname, String? letter, String? modality, String? minId, String? maxId}) async {
  try {
    // Retrieve the token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    // Check if the token is null or empty
    if (token == null || token.isEmpty) {
      throw Exception('Token is null or empty');
    }

    // Construct the URL with query parameters
    final Uri url = Uri.parse('$baseUrl/user/classes?classname=$classname&letter=$letter&modality=$modality&minId=$minId&maxId=$maxId&secret_token=$token');
    print(url);
    print("url acima");
    // Make the HTTP GET request
    final response = await http.get(url);

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> classesJson = json.decode(response.body);
      print(classesJson);
      // Map the JSON objects to ClassesStructure objects
      List<ClassesStructure> classes = classesJson.map((json) => ClassesStructure.fromJson(json)).toList();
      
      // Handle the classes data
      print('Classes: $classes');
      return classes;

    } else {
      // Handle the error response
      throw Exception('Failed to fetch classes. Status code: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any errors that occur during the process
    print('Error: $error');
    throw Exception('Error: $error');
  }
}

}