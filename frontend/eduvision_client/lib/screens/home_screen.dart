// home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo_chefinho.png', // Replace 'your_image.png' with the path to your image asset
              width: 200, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              // You can also use other properties like fit, alignment, etc.
            ),
            SizedBox(height: 20),            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Registre sua senha'),
            ),
          ],
        ),
      ),
    );
  }
}
