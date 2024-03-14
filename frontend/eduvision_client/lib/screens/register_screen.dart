import 'package:flutter/material.dart';
import 'package:eduvision_client/screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? selectedOption;

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
                  value: 'Option 1',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Sou colaborador'),
                  value: 'Option 2',
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
              decoration: InputDecoration(
                labelText: 'RA',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true, // Password field
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirmação de senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement registration functionality here
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Confirmar alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
