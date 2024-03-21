import 'package:eduvision_client/screens/tarefas.dart';
import 'package:eduvision_client/services/tasks_api_service.dart';
import 'package:flutter/material.dart';
import '../model/classes_structure.dart';
import '../services/classes_api_service.dart';

class SelectClassScreen extends StatefulWidget {
  @override
  _SelectClassScreenState createState() => _SelectClassScreenState();
}

class _SelectClassScreenState extends State<SelectClassScreen> {
  String? _selectedClass;
  String? _selectedClassId; // Variable to hold the ID of the selected class
  final TextEditingController _fullNameController = TextEditingController();
  bool _showLoading = false;
  List<String> _classList = [];

  @override
  void initState() {
    super.initState();
    fetchClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar matéria'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedClass,
              hint: Text('Selecione a turma...'),
              items: _classList
                  .map((String value) {
                    List<String> classInfo = value.split(' - ');
                    String idClass = classInfo[0];
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        // Handle selecting class
                        // You can parse the value to extract necessary data if needed
                        _selectedClassId = idClass; // Set the ID of the selected class
                      },
                    );
                  })
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedClass = newValue;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Nome da disciplina',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _showLoading ? null : () async {
                  setState(() {
                    _showLoading = true;
                  });

                  String fullName = _fullNameController.text;
                  String? selectedClassId = _selectedClassId;

                    await getTasksByClass(selectedClassId);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Resultado'),
                        content: Text("oi"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HandleTasksScreen(),
                                ),
                               );
                                // Dismiss the AlertDialog
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );

                  print('Selected Class ID: $selectedClassId');
                  print('Full Name: $fullName');

                  setState(() {
                    _showLoading = false;
                  });
                },
                child: Text(_showLoading ? 'Carregando...' : 'Adicionar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    super.dispose();
  }

  Future<void> fetchClassList() async {
    try {
      // Fetch list of classes and update _classList
      // Replace 'getClasses' with the appropriate method from your API service
      List<ClassesStructure> classes = await ClassesAPIService().getAllClasses();
      setState(() {
        _classList = classes.map((classObj) => '${classObj.idClass} - ${classObj.className} - ${classObj.letter}').toList();
      });
    } catch (e) {
      print(e);
      // Handle error appropriately
    }
  }

  Future<dynamic> getTasksByClass(String? classId) async {
    try {
      // Call the appropriate method to get tasks by class ID
      // Replace 'getTasksByClass' with the appropriate method from your API service
      // and pass the selected class ID
      if (classId == null) {
        return;
      }
      List<dynamic> message = await TaskAPIService().getTasksByClass(classId!);
      return message;
    } catch (error) {
      return 'Erro: $error';
    }
  }
}
