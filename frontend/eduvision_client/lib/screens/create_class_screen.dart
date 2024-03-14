import 'package:eduvision_client/services/classes_api_service.dart';
import 'package:flutter/material.dart';

class CreateClassScreen extends StatefulWidget {
  @override
  _CreateClassScreenState createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _letterController = TextEditingController();
  final TextEditingController _modalityController = TextEditingController();

  @override
  void dispose() {
    _classNameController.dispose();
    _letterController.dispose();
    _modalityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Turma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _classNameController,
              decoration: InputDecoration(labelText: 'Ano (ex: 6º Ano)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _letterController,
              decoration: InputDecoration(labelText: 'Turma (ex: A)'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _modalityController,
              decoration: InputDecoration(labelText: 'Modalidade (ex: Manhã)'),
            ),
            SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                String className = _classNameController.text.trim();
                String letter = _letterController.text.trim();
                String modality = _modalityController.text.trim();
                String message = await ClassesAPIService().createClass(className, letter, modality);
                
                // Show AlertDialog with the returned message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Criar turma'),
                    content: Text(message),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
                child: Text('Adicionar turma'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Your createClass function goes here
