import 'dart:convert';
import 'package:eduvision_client/model/student_grades.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GradesAPIService {
  final String baseUrl = 'http://localhost:8080';

  Future<dynamic> fetchNotesByRASTUD(String RASTUD) async {
  try {
    final response = await http.get(
      Uri.parse('$baseUrl/notes/$RASTUD'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // Add any additional headers if required
      },
    );

    if (response.statusCode == 200) {
        // Request successful, parse the response
        List<dynamic> data = jsonDecode(response.body);
        print('Note: $data');

        List<StudentGrades> list = [];
        for (dynamic item in data) {
          list.add(StudentGrades.fromJson(item));
          print('portugues');
          print(StudentGrades.fromJson(item).linguaPortuguesa);

        }
        print('lista');
        print(list);
        return list;
    } else if (response.statusCode == 404) {
      // Note not found
      print('Note not found');
    } else {
      // Request failed
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // An error occurred
    print('Errora: $error');
  }
}


}