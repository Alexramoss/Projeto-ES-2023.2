// import 'package:eduvision_client/model/classes_structure.dart';
// import 'package:eduvision_client/services/classes_api_service.dart';
// import 'package:flutter/material.dart';

// class AddStudentScreen extends StatefulWidget {
//   @override
//   _AddStudentScreenState createState() => _AddStudentScreenState();
// }

// class _AddStudentScreenState extends State<AddStudentScreen> {
//   String? _selectedClass;
//   final TextEditingController _fullNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Adicionar novo aluno'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FutureBuilder<List<String>>(
//               future: getListOfClasses(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return DropdownButtonFormField<String>(
//                     value: _selectedClass,
//                     hint: Text('Selecione a turma...'),
//                     items: snapshot.data!
//                         .map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         })
//                         .toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedClass = newValue;
//                       });
//                     },
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _fullNameController,
//               decoration: InputDecoration(
//                 labelText: 'Nome Completo',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 32.0),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Add your logic to save the student data
//                   String fullName = _fullNameController.text;
//                   String email = _emailController.text;
//                   String selectedClass = _selectedClass ?? '';

//                   print('Selected Class: $selectedClass');
//                   print('Full Name: $fullName');
//                   print('Email: $email');

                  
//                 },
//                 child: Text('Adicionar Estudante'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

// Future<List<String>> getListOfClasses() async {
//   try {
//     List<ClassesStructure> classes = await ClassesAPIService().getAllClasses();
//     List<String> classNames = classes.map((classObj) => '${classObj.className} - ${classObj.letter} - ${classObj.modality}').toList();
//     return classNames;
//   } catch (e) {
//     print(e);
//     throw e;
//   }
// }

// }

import 'package:eduvision_client/model/classes_structure.dart';
import 'package:eduvision_client/services/classes_api_service.dart';
import 'package:eduvision_client/services/user_API_service.dart';
import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  String? _selectedClass;
  String? _selectedClassId; // Add a variable to hold the ID of the selected class
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
        title: Text('Adicionar novo aluno'),
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
                    String className = classInfo[1];
                    String letter = classInfo[2];
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      onTap: () {
                        _selectedClassId = idClass;
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
                onPressed: _showLoading ? null : () async {
                  setState(() {
                    _showLoading = true;
                  });

                  String fullName = _fullNameController.text;
                  String email = _emailController.text;
                  String? selectedClassId = _selectedClassId;

                  String message = await addStudent();

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Resultado'),
                        content: Text(message),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
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
                  print('Email: $email');

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
    _emailController.dispose();
    super.dispose();
  }

  Future<void> fetchClassList() async {
    try {
      List<ClassesStructure> classes = await ClassesAPIService().getAllClasses();
      setState(() {
        _classList = classes.map((classObj) => '${classObj.idClass} - ${classObj.className} - ${classObj.letter} - ${classObj.modality}').toList();
      });
    } catch (e) {
      print(e);
      // Handle error appropriately
    }
  }

  Future<String> addStudent() async {
    try {
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String? selectedClassId = _selectedClassId;

      if (fullName.isEmpty || email.isEmpty || selectedClassId == null) {
        return 'Por favor, preencha todos os campos';
      }

      await UserAPIService().register(
        fullname: fullName,
        email: email,
        isStudent: true,
        idClass: selectedClassId,
        role: 'student',
      );

      _fullNameController.clear();
      _emailController.clear();

      return 'Estudante adicionado!';
    } catch (error) {
      return 'Erro: $error';
    }
  }
}
