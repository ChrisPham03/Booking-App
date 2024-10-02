import 'package:flutter/material.dart';
import 'screen/checkin_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckInPage(), // Set the initial screen to CheckInPage
    );
  }
}