import 'package:eduvision_client/services/user_API_service.dart';
import 'package:flutter/material.dart';

class AddManagerScreen extends StatefulWidget {
  @override
  _AddManagerScreenState createState() => _AddManagerScreenState();
}

class _AddManagerScreenState extends State<AddManagerScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar novo gerente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            SizedBox(height: 16.0),
            TextField(
              controller: _roleController,
              decoration: InputDecoration(
                labelText: 'Cargo',
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
                  String role = _roleController.text;

                  String message = await addCollaborator();

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

                  print('Full Name: $fullName');
                  print('Email: $email');
                  print('Email: $role');


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

  Future<String> addCollaborator() async {
    try {
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String role = _emailController.text;

      if (fullName.isEmpty || email.isEmpty || role.isEmpty) {
        return 'Por favor, preencha todos os campos';
      }

      await UserAPIService().register(
              fullname: fullName,
              email: email,
              isStudent: false,
              role: role,
            );      
      _fullNameController.clear();
      _emailController.clear();
      _roleController.clear();


      return 'Gerente adicionado!';
    } catch (error) {
      return 'Erro: $error';
    }
  }

}
