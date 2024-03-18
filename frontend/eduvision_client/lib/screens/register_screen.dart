import 'package:eduvision_client/services/user_API_service.dart';
import 'package:flutter/material.dart';
import 'package:eduvision_client/screens/home_screen.dart';

class RegisterPasswordScreen extends StatefulWidget {
  @override
  _RegisterPasswordScreenState createState() => _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState extends State<RegisterPasswordScreen> {
  String? selectedOption;
    final TextEditingController _RAController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
        final TextEditingController _passwordConfirmationController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Radio button for selecting an option
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Select Option:',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                RadioListTile(
                  title: Text('Sou estudante ou responsável'),
                  value: 'true',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Sou colaborador'),
                  value: 'false',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Text fields for registration
            TextField(
              controller: _RAController,
              decoration: InputDecoration(
                labelText: 'RA',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true, // Password field
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true, // Password field
              controller: _passwordConfirmationController,
              decoration: InputDecoration(
                labelText: 'Confirmação de senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String id = _RAController.text;
                String password = _passwordController.text;
                String confirmationPassword = _passwordConfirmationController.text;

                String message = await UserAPIService().editPassword(id: id, password: password, confirmationPassword: confirmationPassword, isStudent: selectedOption ?? '');
showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Resultado'),
                        content: Text(message),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );

              },
              child: Text('Confirmar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
