import 'package:eduvision_client/services/user_API_service.dart';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import the DashboardScreen
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedOption;
  UserAPIService apiService = UserAPIService();
  
  // TextEditingController for RA TextField
  TextEditingController _raController = TextEditingController(text: '');
  
  // TextEditingController for Password TextField
  TextEditingController _passwordController = TextEditingController(text:'');

  @override
  void initState() {
    super.initState();
    _updateSharedPreferencesOnLoad();
    


  }

  Future<void> _updateSharedPreferencesOnLoad() async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('isStudent', '');
    await prefs.setString('token', '');

    print('User preference saved');
  }

  @override
  Widget build(BuildContext context)  {
    SharedPreferences prefs;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                RadioListTile(
                  title: Text('Sou estudante ou responsável'),
                  value: 'student',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('Sou colaborador'),
                  value: 'collaborator',
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
            TextField(
              controller: _raController, // Assign RA controller
              decoration: InputDecoration(
                labelText: 'RA',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController, // Assign password controller
              obscureText: true, // Password field
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              
              onPressed: () async {
                 String id = _raController.text; // Retrieve RA value
                 String password = _passwordController.text; // Retrieve password value
                 String role = selectedOption ?? ''; // Retrieve selected role
                 
                 // Call the sign-in method from the API service
                 await apiService.signIn(id: id, password: password, role: role);

                 // Save selected role to SharedPreferences
                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 await prefs.setString('isStudent', selectedOption ?? '');
                 print('User preference saved');
                 
                 // Navigate to DashboardScreen

                 String? token = prefs.getString('token');
                 var userProfile = await apiService.fetchUserProfile(token!);

                  if (prefs.getString("isStudent") == "student" && prefs.getString("token") != '')  {
                    prefs.setString('rastud', userProfile!.id);
                    _raController.text = "";
                    _passwordController.text = "";
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen(fullName: userProfile.name , studentClass: userProfile.idClass)),
                );
                  } 
                   else if (prefs.getString("isStudent") == "collaborator" && prefs.getString("token") != '')  {
                   _raController.text = "";
                    _passwordController.text = "";
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen(fullName: userProfile!.name , occupation: userProfile.occupation)),
                );
                } else {
                  // Token does not exist, handle accordingly
                  print('Token not found in SharedPreferences');
                }


                 
                // Implement login functionality here
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

