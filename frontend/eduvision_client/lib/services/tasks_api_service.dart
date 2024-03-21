import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TaskAPIService {
  final String baseUrl = 'http://localhost:8080';

  TaskAPIService();

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<dynamic>> getTasksByClass(String idClass) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return [];
      }
      final response = await http.get(
        Uri.parse('$baseUrl/tasks/class/$idClass?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }

Future<List<dynamic>> getTasksByStatus(String status) async {
  try {
    String? token = await _getToken();
    if (token == null) {
      print('Token is null');
      return [];
    }
    final response = await http.get(
      Uri.parse('$baseUrl/tasks/status?secret_token=$token&status=$status'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return [];
    }
  } catch (error) {
    print('Error: $error');
    return [];
  }
}

  Future<String> addTask(Map<String, dynamic> taskData) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print('Token is null');
        return 'Token is null';
      }
      final response = await http.post(
        Uri.parse('$baseUrl/tasks?secret_token=$token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(taskData),
      );

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
        Uri.parse('$baseUrl/tasks/$id?secret_token=$token'),
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
        Uri.parse('$baseUrl/tasks/$id?secret_token=$token'),
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
