import 'package:eduvision_client/model/board.dart';
import 'package:eduvision_client/screens/tasks.dart';
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
  List<BoardItemObject> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchClassList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolher turma'),
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
            
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: _showLoading ? null : () async {
                  setState(() {
                    _showLoading = true;
                  });

                  String fullName = _fullNameController.text;
                  String? selectedClassId = _selectedClassId;

                    // await getTasksByClass(selectedClassId);
                  String message = await getTasksByClass(_selectedClassId);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Resultado'),
                        content: Text(message),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {

                              if(_selectedClassId != null) {
                                Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => HandleTasksScreen(items: tasks, idClass: _selectedClassId!),
                                ),
                               );
                              }
                                
                              

                              
                              
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
                child: Text(_showLoading ? 'Carregando...' : 'Próximo'),
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

  Future<String> getTasksByClass(String? classId) async {
    try {
      // Call the appropriate method to get tasks by class ID
      // Replace 'getTasksByClass' with the appropriate method from your API service
      // and pass the selected class ID
      if (classId == null) {
        return('Escolha uma turma');
      }
      tasks = await TaskAPIService().getTasksByClass(classId!);
      if (tasks.isEmpty) {
      return('Nenhuma tarefa encontrada para essa turma');
    } else {
      return('Tarefas encontradas');
    }
    } catch (error) {
      throw 'Erro: $error';
    }
  }
}
