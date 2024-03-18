

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_screen.dart'; // Import the DashboardScreen


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login/Register App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterPasswordScreen(),
        '/dashboard': (context) => DashboardScreen(fullName: '', studentClass: ''), // Add route for DashboardScreen

      },
      // color: Color(0xFF20B4A6),
//       theme: ThemeData(
//         primaryColor: Colors.black, 
//         primarySwatch: Colors.red,
// // Set primary color to blue
//         // accentColor: Colors.blue, // Set accent color to blueAccent

//         scaffoldBackgroundColor: Color(0xFFCBF3F0),
//         appBarTheme: AppBarTheme(
//           color: Color(0xFFCBF3F0), // Set the standard AppBar background color
//         ),
//         cardTheme: CardTheme(
//           color: Color(0xFFCBF3F0), // Set the default Card widget color
//         ),
//  buttonTheme: ButtonThemeData(
//           buttonColor: Color(0xFFFFFFFF), // Set the default button color
//   textTheme: ButtonTextTheme.primary, // Set button text color to red
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           fillColor: Color(0xFFFFFFFF), // Set the default background color of text fields
//           filled: true,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(2.0), // Set the default border radius for text fields
//           ),
//         ),
//       ),
    
     theme: ThemeData(
        // Define the overall theme of your app
        primaryColor: Colors.black,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Color(0xFFCBF3F0),
        appBarTheme: AppBarTheme(
          color: Color(0xFFCBF3F0),
        ),
        cardTheme: CardTheme(
          color: Color(0xFFCBF3F0),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFFFFFFF),
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xFFFFFFFF),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                // Use different colors for different button states if needed
                if (states.contains(MaterialState.disabled)) {
                  // Return the color for disabled state
                  return Colors.grey;
                }
                // Return the default color for enabled state
                return Color(0xFFFFFFFF);
              },
            ),
            ),
            // Customize other button properties as needed
          ),
     ),
    );
  }
}

