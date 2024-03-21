import 'dart:convert';
import 'package:eduvision_client/model/board.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskAPIService {
  final String baseUrl = 'http://localhost:8080/user';

  TaskAPIService();

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<BoardItemObject>> getTasksByClass(String idClass) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return [];
      }
      final response = await http.get(
        Uri.parse('$baseUrl/task/$idClass?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
              print('sucesso');
              print('Response body: ${response.body}');

        // Check if the response body contains the "No tasks found" message
      if (response.body == '["No tasks found for the provided parameter"]') {
        print('No tasks found');
        return [];
      }


        List<dynamic> data = jsonDecode(response.body);
        List<BoardItemObject> tasks = data.map((taskJson) => BoardItemObject.fromJson(taskJson)).toList();
        print(tasks.first.title);


        return tasks;
      } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching tasks: $error');
    }
  }

Future<List<BoardItemObject>> getTasksByStatus(String status) async {
  try {
    String? token = await _getToken();
    if (token == null) {
      print('Token is null');
      return [];
    }
    final response = await http.get(
      Uri.parse('$baseUrl/task?secret_token=$token&status=$status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<BoardItemObject> tasks = data.map((taskJson) => BoardItemObject.fromJson(taskJson)).toList();

      return tasks;
    } else {
        throw Exception('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error fetching tasks: $error');
    }
}

  Future<String> addTask(Map<String, dynamic> taskData) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return 'Token is null';
      }
    String encodedBody = jsonEncode(taskData);

      final response = await http.post(
        Uri.parse('$baseUrl/task?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: encodedBody,
      );
      print(response.body);
            print(taskData);


      if (response.statusCode == 201) {
        return 'Task added successfully';
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'Failed to add task';
      }
    } catch (error) {
      print('Error: $error');
      return 'Error adding task: $error';
    }
  }

  Future<String> editTask(String id, Map<String, dynamic> taskData) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return 'Token is null';
      }
      final response = await http.put(
        Uri.parse('$baseUrl/task/$id?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 200) {
        return 'Task updated successfully';
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'Failed to update task';
      }
    } catch (error) {
      print('Error: $error');
      return 'Error updating task: $error';
    }
  }

  Future<String> deleteTask(String id) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return 'Token is null';
      }
      final response = await http.delete(
        Uri.parse('$baseUrl/task/$id?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        return 'Task deleted successfully';
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return 'Failed to delete task';
      }
    } catch (error) {
      print('Error: $error');
      return 'Error deleting task: $error';
    }
  }
}
