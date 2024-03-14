import 'package:eduvision_client/model/classes_structure.dart';
import 'package:eduvision_client/services/classes_api_service.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  String? _selectedClass;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar novo aluno'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<String>>(
              future: getListOfClasses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return DropdownButtonFormField<String>(
                    value: _selectedClass,
                    hint: Text('Selecione a turma...'),
                    items: snapshot.data!
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedClass = newValue;
                      });
                    },
                  );
                }
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your logic to save the student data
                  String fullName = _fullNameController.text;
                  String email = _emailController.text;
                  String selectedClass = _selectedClass ?? '';

                  print('Selected Class: $selectedClass');
                  print('Full Name: $fullName');
                  print('Email: $email');
                },
                child: Text('Add Student'),
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
    _emailController.dispose();
    super.dispose();
  }

Future<List<String>> getListOfClasses() async {
  try {
    List<ClassesStructure> classes = await ClassesAPIService().getAllClasses();
    List<String> classNames = classes.map((classObj) => '${classObj.className} - ${classObj.letter} - ${classObj.modality}').toList();
    return classNames;
  } catch (e) {
    print(e);
    throw e;
  }
}

}
