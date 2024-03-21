import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eduvision_client/model/dashboard_options.dart';
import 'package:eduvision_client/services/navigation_service.dart'; // Import the NavigatorService

class DashboardScreen extends StatelessWidget {
  final String? fullName;
  final String? studentClass;
  final String? occupation;

  DashboardScreen({required this.fullName, this.studentClass, this.occupation});

  @override
  Widget build(BuildContext context) {
    // Add ScopedWillPopCallback to handle back button press
    ModalRoute.of(context)?.addScopedWillPopCallback(() async {
      // Custom logic to handle back button press
      bool shouldNavigateBack = await showDialog(
        context: context,
        builder: (BuildContext context) {
          SharedPreferences prefs;
          return AlertDialog(
            title: Text('Confirmação de Logout'),
            content: Text('Tem certeza de que deseja sair?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Não'),
              ),
              TextButton(
                onPressed: () async =>  {
                 prefs = await SharedPreferences.getInstance(),
                 prefs.setString("isStudent", ''),
                 prefs.setString('token', ''),
                 print(prefs.getString("isStudent")),
                 print(prefs.getString("token")),

                  Navigator.of(context).pop(true),


                },
                child: Text('Sim'),
              ),
            ],
          );
        },
      );
      // Return true to allow back navigation if the user confirms
      return shouldNavigateBack ?? false;
    });

    return Scaffold(
      backgroundColor: Color(0xFF20B4A6),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              'Dashboard',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 2),
            Text(
              'Nome: $fullName',
              style: TextStyle(fontSize: 14),
            ),
            Text(
              studentClass != null ? 'Classe: $studentClass' : 'Ocupação: $occupation',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8), // Adjust spacing between icon and text
          ],
        ),
        centerTitle: false, // Align title and other attributes to the left
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16), // Add horizontal padding
          child: Container(
            // padding: EdgeInsets.all(16), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'Recursos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FutureBuilder<List<DashboardOption>>(
                    future: _getDashboardOptions(), // Get options from shared preferences
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Show loading indicator while fetching data
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}'); // Show error message if an error occurs
                      } else {
                        return GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data!.map((option) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to the selected screen
                                NavigatorService.navigateToScreen(context, option.title);
                              },
                              child: Card(
                                elevation: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      option.icon,
                                      size: 48,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      option.title,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 16), // Spacer between grids and title
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 64),
                    Text(
                      'Chefinho da semana',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card (
                        elevation: 3,
                        child: Center (
                          child: Text(
                            'João da Silva',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to get dashboard options from shared preferences
  Future<List<DashboardOption>> _getDashboardOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Example: Retrieve options from shared preferences and return them
    if (prefs.getString("isStudent") == "student" && prefs.getString("token") != '')  {
      return StudentsDashboardItems().presetOptions;
    }
    print("passei aqui ");
    return StaffDashboardItems().presetOptions;
  }
}


